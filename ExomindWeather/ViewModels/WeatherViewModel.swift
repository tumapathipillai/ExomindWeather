import Foundation

final class WeatherViewModel: ObservableObject {
    @Published var loadedCities = [CityWeather]()
    @Published var error: Error?

    static let timeInterval: Int = 1
    static let totalTimeInterval: Int = 60
    @Published var timer = Timer.publish(every: TimeInterval(timeInterval), on: .main, in: .common).autoconnect()
    @Published var timerEnabled = true
    @Published private(set) var loadingProgressValue: Int = 0

    var progressRatio: CGFloat {
        CGFloat(loadingProgressValue) / CGFloat(Self.totalTimeInterval)
    }
    
    @Published private var loadingMessageIndex: Int = 0
    static private let loadingMessages: [String] = [
        LocalizeKeys.loadingMessage1.localizedString,
        LocalizeKeys.loadingMessage2.localizedString,
        LocalizeKeys.loadingMessage3.localizedString,
    ]

    var loadingMessage: String {
        return Self.loadingMessages[loadingMessageIndex]
    }

    private let service: WeatherService

    
    init(service: WeatherService) {
        self.service = service
        reset()
    }
    
    func reset() {
        self.loadingProgressValue = 0
        self.loadedCities = []
        self.error = nil
        self.timerEnabled = true
        
    }

    func onTimerTick() {
        if error != nil {
            timerEnabled = false
        } else {
            switch loadingProgressValue {
            case 0:
                self.fetchWeather(of: .rennes)
            case 10:
                self.fetchWeather(of: .paris)
            case 20:
                self.fetchWeather(of: .nantes)
            case 30:
                self.fetchWeather(of: .bordeaux)
            case 40:
                self.fetchWeather(of: .lyon)
            default:
                break
            }
            
            if loadingProgressValue.isMultiple(of: 6) {
                if loadingMessageIndex >= Self.loadingMessages.count - 1 {
                    loadingMessageIndex = 0
                } else {
                    loadingMessageIndex += 1
                }
            }
            
            if loadingProgressValue < Self.totalTimeInterval {
                self.loadingProgressValue += 1
            } else {
                self.timerEnabled = false
            }
        }
    }
    
    private func fetchWeather(of city: City) {
        Task(priority: .background) {
            do {
                let response = try await service.getWeather(for: city)
                
                if let model = CityWeather(from: response) {
                    await MainActor.run {
                        loadedCities.append(model)
                    }
                } else {
                    await MainActor.run {
                        self.error = MapperError.invalidValue
                    }
                }
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }
}
