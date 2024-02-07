import Foundation
@testable import ExomindWeather

final class MockWeatherService: WeatherService {
    let getWeatherMock: (City) throws -> CityWeatherResponse
    
    private static func throwMethodNotImplemented<T>() throws -> T {
        fatalError("Method not implemented")
    }

    init(
        getWeatherMock: @escaping (City) throws -> CityWeatherResponse = { _ in
            try throwMethodNotImplemented()
        }
    ) {
        self.getWeatherMock = getWeatherMock
    }

    func getWeather(for city: City) async throws -> CityWeatherResponse {
        try getWeatherMock(city)
    }
}
