import UIKit

public enum MenuFactory {
    public static func make() -> UIViewController {
        let coordinator = MenuCoordinator()
        let presenter = MenuPresenter(coordinator: coordinator)
        let service = MenuService()
        let interactor = MenuInteractor(presenter: presenter, service: service)
        let viewController = MenuViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
