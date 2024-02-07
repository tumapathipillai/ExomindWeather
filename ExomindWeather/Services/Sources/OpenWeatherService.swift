import Foundation

class OpenWeatherService: WeatherService {
    static let host = "https://api.openweathermap.org/data/2.5/weather"

    func getWeather(for city: City) async throws -> CityWeatherResponse {
        guard var urlComponents = URLComponents(string: Self.host) else {
            throw ApiError.unknownHost
        }
        
        guard let apiKey = Config.stringValue(forKey: "WeatherApiKey") else {
            fatalError("No api key provided. Please refer to the README to setup the project")
        }

        let queryItems = [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "id", value: city.weatherId),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            throw ApiError.unknownError
        }
        
        let urlResponse = try await URLSession.shared.data(from: url)
        
        guard let response: CityWeatherResponse = try? jsonDecode(from: urlResponse.0) else {
            throw ApiError.invalidFormat
        }

        return response
    }
    
    private func jsonDecode<T: Decodable>(from data: Data) throws -> T {
        let decoder = JSONDecoder()
        
        let decodedData = try decoder.decode(T.self, from: data)
            
        return decodedData
    }
}

fileprivate extension City {
    var weatherId: String {
        switch self {
        case .rennes:
            "2983990"
        case .paris:
            "2988506"
        case .nantes:
            "2990969"
        case .bordeaux:
            "5905868"
        case .lyon:
            "6454573"
        }
    }
}
