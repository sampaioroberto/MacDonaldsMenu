import Foundation

protocol LocalizeRepresentable: RawRepresentable {
    var localized: String { get }
}

extension LocalizeRepresentable where RawValue == String {
    var localized: String {
        return NSLocalizedString(rawValue, bundle: .module, comment: rawValue)
    }

    func localized(with parameters: String...) -> String {
        return String(format: self.localized, arguments: parameters)
    }
}

enum RequestErrorText: String, LocalizeRepresentable {
    case emptyTitle = "RequestError.Empty.title"
    case emptyDescription = "RequestError.Empty.description"
    case unexpectedTitle = "RequestError.Unexpected.title"
    case unexpectedDescription = "RequestError.Unexpected.description"
}
