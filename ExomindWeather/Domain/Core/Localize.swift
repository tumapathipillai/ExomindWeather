import Foundation

enum LocalizeKeys: String {
    case welcome = "HOME_WELCOME"
    case welcomeButton = "HOME_WELCOME_BUTTON"
    case error = "ERROR"
    case retry = "RETRY"
    case restart = "RESTART"
    case humidity = "HUMIDITY"
    case loadingMessage1 = "LOADING_MESSAGE_1"
    case loadingMessage2 = "LOADING_MESSAGE_2"
    case loadingMessage3 = "LOADING_MESSAGE_3"
    
    var localizedString: String {
        Bundle.main.localizedString(forKey: self.rawValue, value: "", table: "Localizable")
    }
}
