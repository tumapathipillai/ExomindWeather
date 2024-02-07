import Foundation

enum Config {
    static func stringValue(forKey key: String) -> String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            return nil
        }
        return value
    }
}
