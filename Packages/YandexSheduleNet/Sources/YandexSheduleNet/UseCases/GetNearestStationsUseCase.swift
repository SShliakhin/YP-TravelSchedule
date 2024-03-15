/*
 Список ближайших станций
 Запрос позволяет получить список станций, находящихся в указанном радиусе от указанной точки. Максимальное количество возвращаемых станций — 50.

 Точка определяется географическими координатами (широтой и долготой) согласно WGS84
 https://yandex.ru/dev/rasp/doc/ru/reference/query-nearest-station

 https://api.rasp.yandex.net/v3.0/nearest_stations/?apikey=КЛЮЧ&format=json&lat=50.440046&lng=40.4882367&distance=50&lang=ru_RU
 - в этом примере, до 20 км станций нет - а с 30 выдает ошибку декодирования
 - подставил координаты из учебника + уменьшил дистанцию до 1 км
 */

import OpenAPIRuntime

public protocol GetNearestStationsUseCase {
	func invoke(
		lat: Double,
		lng: Double,
		distance: Int,
		offset: Int?,
		limit: Int?,
		format: Format?,
		language: String?
	) async throws -> NearestStations
	func invoke()
}

public final class GetNearestStationsUseCaseImp: GetNearestStationsUseCase {
	private let client: Client

	init(client: Client) {
		self.client = client
	}

	public func invoke() {
		let lat = 59.864177
		let lng = 30.319163
		let distance = 1

		Task {
			do {
				let result = try await invoke(lat: lat, lng: lng, distance: distance)
				print("==========")
				print("Nearest stations")
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
		distance: Int,
		offset: Int? = nil,
		limit: Int? = nil,
		format: Format? = nil,
		language: String? = nil
	) async throws -> NearestStations {
		let response = try await client.getNearestStations(
			query: .init(
				lat: lat,
				lng: lng,
				distance: distance,
				offset: offset,
				limit: limit,
				format: format,
				lang: language
			)
		)

		return try response.ok.body.json
	}
}
