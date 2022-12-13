@testable import MenuScene
import Network

final class MenuServiceMock: MenuServicing {
    var menuResult: Result<Menu, WebServiceError>?

    func fetchMenu(completion: @escaping (Result<Menu, WebServiceError>) -> Void) {
        guard let menuResult = menuResult else { return }
        completion(menuResult)
    }
}
