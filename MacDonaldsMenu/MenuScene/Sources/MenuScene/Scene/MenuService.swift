import Foundation
import Network

protocol MenuServicing {
    func fetchMenu(completion: @escaping (Result<Menu, WebServiceError>) -> Void)
}

struct MenuService: MenuServicing {
    func fetchMenu(completion: @escaping (Result<Menu, WebServiceError>) -> Void) {
        BaseWebServiceBuilder.build().request(path: .menu) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}
