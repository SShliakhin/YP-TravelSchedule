/*
 Список станций следования
 Запрос позволяет получить список станций следования нитки по указанному идентификатору нитки, информацию о каждой нитке и о промежуточных станциях нитки.

 Идентификатор нитки можно получить в ответах на запросы: Расписание рейсов между станциями, Расписание рейсов по станции.
 https://yandex.ru/dev/rasp/doc/ru/reference/list-stations-route

 https://api.rasp.yandex.net/v3.0/stations_list/?apikey=КЛЮЧ&lang=ru_RU&format=json
 */

import Foundation
import OpenAPIRuntime

public protocol GetStationsUseCase {
	func invoke(
		lang: String?,
		format: Format?
	) async throws -> HTTPBody
	func invoke()
}

public final class GetStationsUseCaseImp: GetStationsUseCase {
	private let client: Client

	init(client: Client) {
		self.client = client
	}

	public func invoke() {
		Task {
			do {
				let result = try await invoke()
				let resultData = try await Data(collecting: result, upTo: 40 * 1024 * 1024)
				print("==========")
				print("Stations - stations_list")
				print(resultData)
			}
			catch {
				print(error.localizedDescription)
			}
		}
	}

	public func invoke(
		lang: String? = nil,
		format: Format? = nil
	) async throws -> HTTPBody {
		let response = try await client.getStations(
			query: .init(
				lang: lang,
				format: format
			)
		)

		return try response.ok.body.html
	}
}
