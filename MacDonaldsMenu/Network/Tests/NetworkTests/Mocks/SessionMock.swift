@testable import Network
import Foundation

final class SessionMock: Session {
    private var dataTask = DataTaskMock()
    var data: Data?
    var URLResponse: URLResponse?
    var error: Error?

    func customDataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> DataTask {
        completionHandler(data, URLResponse, error)
        return dataTask
    }
}

struct DataTaskMock: DataTask {
    func resume() { }
}
