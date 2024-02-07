import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel(service: OpenWeatherService())
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            if let error = viewModel.error {
                ErrorView(error: error) {
                    viewModel.reset()
                }
            } else {
                if viewModel.progressRatio < 1.0 {
                    WeatherLoadingMessage(message: viewModel.loadingMessage)
                } else {
                    WeatherList(cityWeathers: viewModel.loadedCities)
                }
                Spacer()
                TimerView(ratio: viewModel.progressRatio, retry: viewModel.reset)
                    .onReceive(viewModel.timer) { _ in
                        if viewModel.timerEnabled {
                            withAnimation(.linear(duration: .init(WeatherViewModel.timeInterval))) {
                                viewModel.onTimerTick()
                            }
                        }
                    }
            }
        }
        .padding(.horizontal, 20)
        .background(Color.background)
        .toolbarBackItem(title: "Home") {
            dismiss()
        }
    }
}

#Preview {
    WeatherView()
}
