import Foundation

struct CityWeatherResponse: Decodable {
    let name: String
    let weather: [WeatherResponse]
    let main: MainResponse
}

extension CityWeather {
    init?(from response: CityWeatherResponse) {
        guard let city = City(rawValue: response.name.lowercased()) else {
            return nil
        }

        guard let weatherIcon = response.weather.first?.icon else {
            return nil
        }

        self.init(city: city,
                  weatherIcon: weatherIcon,
                  temperature: response.main.temp,
                  humidity: response.main.humidity)
    }
}
