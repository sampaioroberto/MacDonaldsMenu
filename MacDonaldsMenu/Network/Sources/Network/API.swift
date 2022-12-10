public enum Path: String {
    case menu = "menu"
}

struct API {
    private let host = "https://mcdonalds.trio.dev/"
    private let path: Path

    init(path: Path) {
        self.path = path
    }

    var value: String {
        "\(host)/\(path.rawValue)"
    }
}
