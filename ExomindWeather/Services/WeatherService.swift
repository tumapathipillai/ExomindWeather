import Foundation

protocol WeatherService {
    func getWeather(for city: City) async throws -> CityWeatherResponse
}
