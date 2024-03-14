/*
 Расписание рейсов между станциями
 Запрос позволяет получить список рейсов, следующих от указанной станции отправления к указанной станции прибытия и информацию по каждому рейсу.
 https://yandex.ru/dev/rasp/doc/ru/reference/schedule-point-point
 */

import OpenAPIRuntime

public protocol GetScheduleUseCase {
	func invoke(
		from: String,
		to: String,
		format: Format?,
		lang: String?,
		date: String?,
		transportTypes: TransportTypes?,
		system: System?,
		showSystems: System?,
		offset: Int?,
		limit: Int?,
		addDaysMask: Bool?,
		resultTimezone: String?,
		transfers: Bool?
	) async throws -> StationsSchedule
	func invoke()
}

public final class GetScheduleUseCaseImp: GetScheduleUseCase {
	private let client: Client
	private let apikey: String

	init(client: Client, apikey: String) {
		self.client = client
		self.apikey = apikey
	}

	public func invoke() {
		let from = "c29398"
		let to = "c28601"

		Task {
			do {
				let result = try await invoke(from: from, to: to)
				print("==========")
				print("Schedule")
				print(result)
			}
			catch {
				print(error.localizedDescription)
			}
		}
	}

	public func invoke(
		from: String,
		to: String,
		format: Format? = nil,
		lang: String? = nil,
		date: String? = nil,
		transportTypes: TransportTypes? = nil,
		system: System? = nil,
		showSystems: System? = nil,
		offset: Int? = nil,
		limit: Int? = nil,
		addDaysMask: Bool? = nil,
		resultTimezone: String? = nil,
		transfers: Bool? = nil
	) async throws -> StationsSchedule {
		let response = try await client.getSchedule(
			query: .init(
				apikey: apikey,
				from: from,
				to: to,
				format: format,
				lang: lang,
				date: date,
				transport_types: transportTypes,
				system: system,
				show_systems: showSystems,
				offset: offset,
				limit: limit,
				add_days_mask: addDaysMask,
				result_timezone: resultTimezone,
				transfers: transfers
			)
		)

		return try response.ok.body.json
	}
}
