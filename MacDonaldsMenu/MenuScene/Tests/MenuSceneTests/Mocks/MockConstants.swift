@testable import MenuScene
import Foundation

enum MockConstants {
    static let menu = Menu(menus: [
        ItemList(name: "List1",
                 items: [
                    Item(name: "Item1", url: URL(string: "www.test1.test")!, description: "Description1", price: 1.0),
                    Item(name: "Item2", url: URL(string: "www.test2.test")!, description: "Description2", price: 2.0)
                 ]
                ),
        ItemList(name: "List2",
                 items: [
                    Item(name: "Item3", url: URL(string: "www.test3.test")!, description: "Description3", price: 3.0),
                    Item(name: "Item4", url: URL(string: "www.test4.test")!, description: "Description4", price: 4.0)
                 ]
                )
    ])

    static let item = Item(name: "Item5", url: URL(string: "www.test5.test")!, description: "Description5", price: 5.0)
}
