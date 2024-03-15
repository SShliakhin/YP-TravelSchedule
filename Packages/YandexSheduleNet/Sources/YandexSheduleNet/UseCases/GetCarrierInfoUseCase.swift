/*
 Информация о перевозчике
 Запрос позволяет получить информацию о перевозчике по указанному коду перевозчика.

 Коды перевозчиков можно получить в публичных справочниках кодов, а также в ответах на запросы: Расписание рейсов между станциями, Расписание рейсов по станции, Список станций следования.
 https://yandex.ru/dev/rasp/doc/ru/reference/query-carrier

 без обязательного указания системы кодирования не работает
 
 https://api.rasp.yandex.net/v3.0/carrier/?format=json&apikey=КЛЮЧ&lang=ru_RU&code=TK&system=iata
 */

import OpenAPIRuntime

public protocol GetCarrierInfoUseCase {
	func invoke(
		code: String,
		system: System,
		lang: String?,
		format: Format?
	) async throws -> Carriers
	func invoke()
}

public final class GetCarrierInfoUseCaseImp: GetCarrierInfoUseCase {
	private let client: Client

	init(client: Client) {
		self.client = client
	}

	public func invoke() {
		let code = "TK"
		let system: System = .iata

		Task {
			do {
				let result = try await invoke(code: code, system: system)
				print("==========")
				print("Carrier info - carrier")
				print(result)
			}
			catch {
				print(error.localizedDescription)
			}
		}
	}

	public func invoke(
		code: String,
		system: System,
		lang: String? = nil,
		format: Format? = nil
	) async throws -> Carriers {
		let response = try await client.getCarrierInfo(
			query: .init(
				code: code,
				system: system,
				lang: lang,
				format: format
			)
		)

		return try response.ok.body.json
	}
}
