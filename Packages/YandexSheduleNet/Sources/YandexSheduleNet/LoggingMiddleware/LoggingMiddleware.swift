import OpenAPIRuntime
import Foundation
import HTTPTypes

package struct LoggingMiddleware: ClientMiddleware {
	package func intercept(
		_ request: HTTPRequest,
		body: HTTPBody?,
		baseURL: URL,
		operationID: String,
		next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
	) async throws -> (HTTPResponse, HTTPBody?) {
		let debugDescription = "(\(request.method)): \(baseURL)\(String(describing: request.path))"
		do {
			let (response, responseBody) = try await next(request, body, baseURL)
			print("🟢 \(debugDescription)")
			return (response, responseBody)
		} catch {
			print("❌ \(debugDescription)")
			throw error
		}
	}
}
