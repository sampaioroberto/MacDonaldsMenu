import Foundation

protocol DataTask {
    func resume()
}

protocol Session {
    func customDataTask(with request: URLRequest,
                        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTask
}

extension URLSession: Session {
    func customDataTask(with request: URLRequest,
                        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTask {
        dataTask(with: request, completionHandler: completionHandler)
    }
}

extension URLSessionDataTask: DataTask { }

struct LocalDataTask: DataTask {
    func resume() { }
}
