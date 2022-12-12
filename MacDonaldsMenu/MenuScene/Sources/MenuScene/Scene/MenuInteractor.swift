import Foundation

protocol MenuInteracting: AnyObject {
    func fetchMenu()
}

final class MenuInteractor {
    private let presenter: MenuPresenting
    private let service: MenuServicing

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
                self?.presenter.presentMenu(menu)
            case .failure:
                self?.presenter.presentError(type: .unexpected)
            }
        }
    }
}
