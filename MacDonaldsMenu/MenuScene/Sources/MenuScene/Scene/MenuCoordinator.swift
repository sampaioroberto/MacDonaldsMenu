import Foundation
import UIKit
import MenuDetailsScene

protocol MenuCoordinating: AnyObject {
    func showModalDetailsWithItem(item: Item)
}

final class MenuCoordinator: MenuCoordinating {
    weak var viewController: UIViewController?

    func showModalDetailsWithItem(item: Item) {
        let itemDetailsViewController = MenuDetailsFactory.make(
            imageURL: item.url,
            title: item.name,
            value: item.price,
            description: item.description)
        viewController?.present(itemDetailsViewController, animated: true)
    }
}
