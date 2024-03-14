/*
 Расписание рейсов по станции
 Запрос позволяет получить список рейсов, отправляющихся от указанной станции и информацию по каждому рейсу.
 https://yandex.ru/dev/rasp/doc/ru/reference/schedule-on-station
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
	private let apikey: String

	init(client: Client, apikey: String) {
		self.client = client
		self.apikey = apikey
	}

	public func invoke() {
		let station = "s9600213"

		Task {
			do {
				let result = try await invoke(station: station)
				print("==========")
				print("Station schedule")
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
				apikey: apikey,
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
