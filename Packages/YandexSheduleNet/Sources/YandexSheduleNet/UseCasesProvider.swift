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
	private let apikey: String

	public init() {
		client = Client(
			serverURL: try! Servers.server1(),
			transport: URLSessionTransport()
		)
		apikey = "ca2a5f01-4337-4580-b78f-5958a122cd28"
	}

	public lazy var getNearestStations: GetNearestStationsUseCase = {
		GetNearestStationsUseCaseImp(client: client, apikey: apikey)
	}()

	public lazy var getSchedule: GetScheduleUseCase = {
		GetScheduleUseCaseImp(client: client, apikey: apikey)
	}()

	public lazy var getStationSchedule: GetStationScheduleUseCase = {
		GetStationScheduleUseCaseImp(client: client, apikey: apikey)
	}()

	public lazy var getDestinationStations: GetDestinationStationsUseCase = {
		GetDestinationStationsUseCaseImp(client: client, apikey: apikey)
	}()

	public lazy var getNearestSettlement: GetNearestSettlementUseCase = {
		GetNearestSettlementUseCaseImp(client: client, apikey: apikey)
	}()

	public lazy var getCarrierInfo: GetCarrierInfoUseCase = {
		GetCarrierInfoUseCaseImp(client: client, apikey: apikey)
	}()

	public lazy var getStations: GetStationsUseCase = {
		GetStationsUseCaseImp(client: client, apikey: apikey)
	}()

	public lazy var getCopyright: GetCopyrightUseCase = {
		GetCopyrightUseCaseImp(client: client, apikey: apikey)
	}()
}
