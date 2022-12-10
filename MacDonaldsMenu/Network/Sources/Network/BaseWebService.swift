import Foundation

public enum BaseWebServiceBuilder {
    public static func build(timeout: TimeInterval = 20.0) -> BaseWebService {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20.0
        configuration.timeoutIntervalForResource = 20.0
        let session = URLSession(configuration: configuration)
        return BaseWebService(session: session)
    }
}

public struct BaseWebService {
    private let session: Session

    init(session: Session) {
        self.session = session
    }

    public func request<T: Decodable>(
        path: Path,
        method: HTTPMethod = .get,
        headerParameters: [String: String] = [:],
        completion: @escaping (Result<T, WebServiceError>) -> Void
    ) {
        let api = API(path: path).value

        guard let components = URLComponents(string: api) else {
            completion(.failure(.malformedURL))
            return
        }

        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }

        var request = URLRequest(url: url)

        if headerParameters.isEmpty == false {
            headerParameters.forEach {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }

        request.httpMethod = method.rawValue

        session.customDataTask(with: request) { data, response, error in
            if let error = error as NSError? {
                switch error.code {
                case NSURLErrorTimedOut:
                    completion(.failure(.timedOut))
                case NSURLErrorNotConnectedToInternet:
                    completion(.failure(.notConnectedToInternet))
                default:
                    completion(.failure(.unexpected))
                }
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unexpected))
                return
            }

            guard 200...299 ~= response.statusCode else {
                completion(.failure(.unexpected))
                return
            }

            guard let data = data else {
                completion(.failure(.unexpected))
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try jsonDecoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.unparseable))
            }
        }.resume()
    }
}
