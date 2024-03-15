import OpenAPIURLSession

public typealias NearestStations = Components.Schemas.NearestStations
public typealias Format = Components.Schemas.Format
public typealias StationsSchedule = Components.Schemas.StationsSchedule
public typealias TransportTypes = Components.Schemas.TransportTypes
public typealias System = Components.Schemas.System
public typealias StationSchedule = Components.Schemas.StationSchedule
public typealias Event = Operations.getStationSchedule.Input.Query.eventPayload
public typealias DestinationStations = Components.Schemas.DestinationStations
public typealias NearestSettlement = Components.Schemas.NearestSettlement
public typealias Carriers = Components.Schemas.Carriers
public typealias Stations = Components.Schemas.Stations
public typealias Copyright = Components.Schemas.Copyright

public final class UseCasesProvider {
	private let client: Client
	private let apikey = "ca2a5f01-4337-4580-b78f-5958a122cd28"

	public init() {
		client = Client(
			serverURL: try! Servers.server1(),
			transport: URLSessionTransport(),
			middlewares: [
				AuthenticationMiddleware(authorizationHeaderFieldValue: apikey),
				LoggingMiddleware()
			]
		)
	}

	public lazy var getNearestStations: GetNearestStationsUseCase = {
		GetNearestStationsUseCaseImp(client: client)
	}()

	public lazy var getSchedule: GetScheduleUseCase = {
		GetScheduleUseCaseImp(client: client)
	}()

	public lazy var getStationSchedule: GetStationScheduleUseCase = {
		GetStationScheduleUseCaseImp(client: client)
	}()

	public lazy var getDestinationStations: GetDestinationStationsUseCase = {
		GetDestinationStationsUseCaseImp(client: client)
	}()

	public lazy var getNearestSettlement: GetNearestSettlementUseCase = {
		GetNearestSettlementUseCaseImp(client: client)
	}()

	public lazy var getCarrierInfo: GetCarrierInfoUseCase = {
		GetCarrierInfoUseCaseImp(client: client)
	}()

	public lazy var getStations: GetStationsUseCase = {
		GetStationsUseCaseImp(client: client)
	}()

	public lazy var getCopyright: GetCopyrightUseCase = {
		GetCopyrightUseCaseImp(client: client)
	}()
}
