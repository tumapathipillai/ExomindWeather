import SwiftUI
import Combine

struct WeatherLoadingMessage: View {
    let message: String

    var body: some View {
        VStack(alignment: .center) {
            Text(message)
                .foregroundStyle(.primaryLabel)
                .multilineTextAlignment(.center)
                .font(.title)
            ProgressView()
                .tint(.white)
        }
    }
}

#Preview {
    WeatherLoadingMessage(message: "")
}
