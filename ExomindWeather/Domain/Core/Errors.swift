import Foundation

enum ApiError: Error {
    case unknownHost
    case unknownError
    case invalidFormat
}

enum MapperError: Error {
    case invalidValue
}
