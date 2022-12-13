import Foundation

protocol MenuPresenting: AnyObject {
    func presentMenu(_ menu: Menu)
    func presentLoading()
    func presentError(type: RequestErrorType)
    func presentDetailsWithItem(_ item: Item)
}

final class MenuPresenter {
    weak var viewController: MenuDisplay?
    var coordinator: MenuCoordinating

    init(coordinator: MenuCoordinating) {
        self.coordinator = coordinator
    }
}

extension MenuPresenter: MenuPresenting {
    func presentMenu(_ menu: Menu) {
        viewController?.displayItemLists(menu.menus)
    }

    func presentLoading() {
        viewController?.displayLoading()
    }

    func presentError(type: RequestErrorType) {
        viewController?.displayError(title: type.title, message: type.description)
    }

    func presentDetailsWithItem(_ item: Item) {
        coordinator.showModalDetailsWithItem(item: item)
    }
}
