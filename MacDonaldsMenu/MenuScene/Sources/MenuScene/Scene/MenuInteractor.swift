import Foundation

protocol MenuInteracting: AnyObject {
    func fetchMenu()
    func didTapOnItemAtIndexPath(_ indexPath: IndexPath)
}

final class MenuInteractor {
    private let presenter: MenuPresenting
    private let service: MenuServicing
    private var itemLists = [ItemList]()

    init(presenter: MenuPresenting, service: MenuServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension MenuInteractor: MenuInteracting {
    func fetchMenu() {
        presenter.presentLoading()
        service.fetchMenu { [weak self] response in
            switch response {
            case let .success(menu):
                guard menu.menus.isEmpty == false else {
                    self?.presenter.presentError(type: .empty)
                    return
                }
                self?.itemLists = menu.menus
                self?.presenter.presentMenu(menu)
            case .failure:
                self?.presenter.presentError(type: .unexpected)
            }
        }
    }

    func didTapOnItemAtIndexPath(_ indexPath: IndexPath) {
        guard indexPath.section < itemLists.count,
              indexPath.item < itemLists[indexPath.section].items.count else {
            return
        }

        let itemList = itemLists[indexPath.section].items
        let item = itemList[indexPath.item]

        presenter.presentDetailsWithItem(item)
    }
}
