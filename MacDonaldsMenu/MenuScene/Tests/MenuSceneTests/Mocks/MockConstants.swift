@testable import MenuScene
import Foundation

enum MockConstants {
    static let menu = Menu(menus: [
        ItemList(name: "List1",
                 items: [
                    Item(name: "Item1", url: URL(string: "www.test1.test")!),
                    Item(name: "Item2", url: URL(string: "www.test2.test")!)
                 ]
                ),
        ItemList(name: "List2",
                 items: [
                    Item(name: "Item3", url: URL(string: "www.test3.test")!),
                    Item(name: "Item4", url: URL(string: "www.test4.test")!)
                 ]
                )
    ])
}
