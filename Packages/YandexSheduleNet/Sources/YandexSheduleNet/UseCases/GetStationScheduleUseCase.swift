/*
 Расписание рейсов по станции
 Запрос позволяет получить список рейсов, отправляющихся от указанной станции и информацию по каждому рейсу.
 https://yandex.ru/dev/rasp/doc/ru/reference/schedule-on-station

 https://api.rasp.yandex.net/v3.0/schedule/?apikey=КЛЮЧ&station=s9600213&transport_types=suburban&direction=на%20Москву
 */

import OpenAPIRuntime

public protocol GetStationScheduleUseCase {
	func invoke(
		station: String,
		lang: String?,
		format: Format?,
		date: String?,
		transportTypes: TransportTypes?,
		direction: String?,
		event: Event?,
		system: System?,
		showSystems: System?,
		resultTimezone: String?
	) async throws -> StationSchedule
	func invoke()
}

public final class GetStationScheduleUseCaseImp: GetStationScheduleUseCase {
	private let client: Client

	init(client: Client) {
		self.client = client
	}

	public func invoke() {
		let station = "s9600213"

		Task {
			do {
				let result = try await invoke(station: station)
				print("==========")
				print("Station schedule - schedule")
				print(result)
			}
			catch {
				print(error.localizedDescription)
			}
		}
	}

	public func invoke(
		station: String,
		lang: String? = nil,
		format: Format? = nil,
		date: String? = nil,
		transportTypes: TransportTypes? = nil,
		direction: String? = nil,
		event: Event? = nil,
		system: System? = nil,
		showSystems: System? = nil,
		resultTimezone: String? = nil
	) async throws -> StationSchedule {
		let response = try await client.getStationSchedule(
			query: .init(
				station: station,
				lang: lang,
				format: format,
				date: date,
				transport_types: transportTypes,
				direction: direction,
				event: event,
				system: system,
				show_systems: showSystems,
				result_timezone: resultTimezone
			)
		)

		return try response.ok.body.json
	}
}
