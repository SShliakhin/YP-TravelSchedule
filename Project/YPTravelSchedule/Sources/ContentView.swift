import SwiftUI
import YandexSheduleNet

struct ContentView: View {
	var body: some View {
		VStack {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundStyle(.tint)
			Text("Hello, world!")
		}
		.padding()
		.onAppear {
			let service = UseCasesProvider()

			service.getNearestStations.invoke()
			service.getSchedule.invoke()
			service.getStationSchedule.invoke()
			service.getDestinationStations.invoke()
			service.getNearestSettlement.invoke()
			service.getCarrierInfo.invoke()
			service.getStations.invoke()
			service.getCopyright.invoke()
		}
	}
}

#Preview {
	ContentView()
}
