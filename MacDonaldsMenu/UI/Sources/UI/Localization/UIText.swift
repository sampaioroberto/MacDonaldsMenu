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

enum ErrorViewText: String, LocalizeRepresentable {
    case tryAgain = "ErrorView.tryAgain"
}
