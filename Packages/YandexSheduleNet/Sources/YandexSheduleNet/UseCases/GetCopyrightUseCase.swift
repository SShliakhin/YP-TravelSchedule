/*
 Копирайт Яндекс Расписаний
 Запрос позволяет получить данные о Яндекс Расписаниях: URL сервиса, баннер в различных цветовых представлениях и уведомительный текст. Все эти данные следует разместить ниже или выше места, в котором расположена информация о расписаниях, в следующем порядке:

 Баннер.
 Уведомительный текст.
 URL Яндекс Расписаний.
 https://yandex.ru/dev/rasp/doc/ru/reference/query-copyright

 https://api.rasp.yandex.net/v3.0/copyright/?apikey=КЛЮЧ&format=json
 */

import OpenAPIRuntime

public protocol GetCopyrightUseCase {
	func invoke(format: Format?) async throws -> Copyright
	func invoke()
}

public final class GetCopyrightUseCaseImp: GetCopyrightUseCase {
	private let client: Client

	init(client: Client) {
		self.client = client
	}

	public func invoke() {
		Task {
			do {
				let result = try await invoke()
				print("==========")
				print("Copyright")
				print(result)
			}
			catch {
				print(error.localizedDescription)
			}
		}
	}

	public func invoke(
		format: Format? = nil
	) async throws -> Copyright {
		let response = try await client.getCopyright(
			query: .init(
				format: format
			)
		)

		return try response.ok.body.json
	}
}
