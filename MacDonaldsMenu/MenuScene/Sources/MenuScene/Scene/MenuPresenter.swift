import Foundation

protocol MenuPresenting: AnyObject {
    func presentMenu(menu: Menu)
    func presentLoading()
    func presentError(type: RequestErrorType)
}

final class MenuPresenter {
    weak var viewController: MenuDisplay?
}

extension MenuPresenter: MenuPresenting {
    func presentMenu(menu: Menu) {
        viewController?.displayItemLists(menu.menus)
    }

    func presentLoading() {
        viewController?.displayLoading()
    }

    func presentError(type: RequestErrorType) {
        viewController?.displayError(title: type.title, message: type.description)
    }
}
