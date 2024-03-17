/*
 Список станций следования
 Запрос позволяет получить список станций следования нитки по указанному идентификатору нитки, информацию о каждой нитке и о промежуточных станциях нитки.

 Идентификатор нитки можно получить в ответах на запросы: Расписание рейсов между станциями, Расписание рейсов по станции.
 https://yandex.ru/dev/rasp/doc/ru/reference/list-stations-route

 https://api.rasp.yandex.net/v3.0/thread/?apikey=КЛЮЧ&uid=LH-126_240320_c1046_12
 */

import OpenAPIRuntime

public protocol GetDestinationStationsUseCase {
	func invoke(
		uid: String,
		form: String?,
		to: String?,
		format: Format?,
		date: String?,
		showSystems: System?
	) async throws -> DestinationStations
	func invoke()
}

public final class GetDestinationStationsUseCaseImp: GetDestinationStationsUseCase {
	private let client: Client

	init(client: Client) {
		self.client = client
	}

	public func invoke() {
		let threadUID = "LH-126_240320_c1046_12"

		Task {
			do {
				let result = try await invoke(uid: threadUID)
				print("==========")
				print("Destination stations - thread")
				print(result)
			}
			catch {
				print(error.localizedDescription)
			}
		}
	}

	public func invoke(
		uid: String,
		form: String? = nil,
		to: String? = nil,
		format: Format? = nil,
		date: String? = nil,
		showSystems: System? = nil
	) async throws -> DestinationStations {
		let response = try await client.getDestinationStations(
			query: .init(
				uid: uid,
				form: form,
				to: to,
				format: format,
				date: date,
				show_systems: showSystems
			)
		)

		return try response.ok.body.json
	}
}
