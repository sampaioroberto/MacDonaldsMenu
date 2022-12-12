import UIKit

public enum MenuFactory {
    public static func make() -> UIViewController {
        let presenter = MenuPresenter()
        let service = MenuService()
        let interactor = MenuInteractor(presenter: presenter, service: service)
        let viewController = MenuViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}
