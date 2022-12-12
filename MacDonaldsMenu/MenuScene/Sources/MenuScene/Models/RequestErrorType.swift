enum RequestErrorType {
    case empty
    case unexpected

    var title: String {
        switch self {
        case .empty:
            return RequestErrorText.emptyTitle.localized
        case .unexpected:
            return RequestErrorText.unexpectedTitle.localized
        }
    }

    var description: String {
        switch self {
        case .empty:
            return RequestErrorText.emptyDescription.localized
        case .unexpected:
            return RequestErrorText.unexpectedDescription.localized
        }
    }
}
