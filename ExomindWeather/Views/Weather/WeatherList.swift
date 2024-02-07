import SwiftUI

struct WeatherList: View {
    let cityWeathers: [CityWeather]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(cityWeathers, id: \.city.rawValue) { cityWeather in
                    WeatherTile(cityWeather: cityWeather)
                }
            }
        }
    }
}

#Preview {
    WeatherList(cityWeathers: [])
}
