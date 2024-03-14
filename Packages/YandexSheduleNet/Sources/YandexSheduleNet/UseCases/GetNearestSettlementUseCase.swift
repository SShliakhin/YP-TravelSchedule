/*
 Ближайший город
 Запрос позволяет получить информацию о ближайшем к указанной точке городе. Точка определяется географическими координатами (широтой и долготой) согласно WGS84. Поиск можно ограничить определенным радиусом (по умолчанию — 10 километров, но не больше 50).
 https://yandex.ru/dev/rasp/doc/ru/reference/nearest-settlement
 */

import OpenAPIRuntime

public protocol GetNearestSettlementUseCase {
	func invoke(
		lat: Double,
		lng: Double,
		distance: Int?,
		lang: String?,
		format: Format?
	) async throws -> NearestSettlement
	func invoke()
}

public final class GetNearestSettlementUseCaseImp: GetNearestSettlementUseCase {
	private let client: Client
	private let apikey: String

	init(client: Client, apikey: String) {
		self.client = client
		self.apikey = apikey
	}

	public func invoke() {
		let lat = 50.440046
		let lng = 40.4882367

		Task {
			do {
				let result = try await invoke(lat: lat, lng: lng)
				print("==========")
				print("Nearest settlement")
				print(result)
			}
			catch {
				print(error.localizedDescription)
			}
		}
	}

	public func invoke(
		lat: Double,
		lng: Double,
		distance: Int? = nil,
		lang: String? = nil,
		format: Format? = nil
	) async throws -> NearestSettlement {
		let response = try await client.getNearestSettlement(
			query: .init(
				apikey: apikey,
				lat: lat,
				lng: lng,
				distance: distance,
				lang: lang,
				format: format
			)
		)

		return try response.ok.body.json
	}
}