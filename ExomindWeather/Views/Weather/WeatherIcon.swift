import SwiftUI

struct WeatherIcon: View {
    let weatherIcon: String
    
    private var iconName: String {
        "https://openweathermap.org/img/wn/\(weatherIcon)@2x.png"
    }

    var body: some View {
        AsyncImage(url: URL(string: iconName)) { data in
            if data.error != nil {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.action)
            } else if let image = data.image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .tint(.black)
            }
        }
        .frame(width: 24, height: 24)
    }
}

#Preview {
    WeatherIcon(weatherIcon: "10d")
}
