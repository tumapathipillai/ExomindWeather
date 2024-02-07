import SwiftUI

extension String {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}

struct WeatherTile: View {
    let cityWeather: CityWeather

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(cityWeather.city.rawValue.firstUppercased)
                    .foregroundStyle(.secondaryLabel)
                    .font(.headline)
                Text("\(LocalizeKeys.humidity.localizedString) : \(cityWeather.humidity) %")
                    .foregroundStyle(.secondaryLabel)
                    .font(.subheadline)
            }
            Spacer()
            Text("\(Int(cityWeather.temperature)) °C")
                .foregroundStyle(.secondaryLabel)
                .font(.caption)
            WeatherIcon(weatherIcon: cityWeather.weatherIcon)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(.white)
        .clipShape(RoundedRectangle(cornerSize: .init(width: 5, height: 5)))
    }
}

#Preview {
    VStack {
        Spacer()
        WeatherTile(cityWeather: CityWeather(city: .paris,
                                             weatherIcon: "10d",
                                             temperature: 20,
                                             humidity: 10))
        
        Spacer()
    }
    .background(.black)
}
