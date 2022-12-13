import Foundation

struct Item: Decodable, Hashable {
    let name: String
    let url: URL
    let description: String
    let price: Double

    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
