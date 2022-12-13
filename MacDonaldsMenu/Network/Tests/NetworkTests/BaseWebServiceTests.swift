import XCTest
@testable import Network

struct TestModel: Codable {
    let test: String
}

extension BaseWebService {
    static func jsonDataSuccess() -> Data? {
        let jsonSuccess: [String: String] = ["test": "ok"]
        return try? JSONSerialization.data(withJSONObject: jsonSuccess)
    }

    static func notJSONDataSuccess() -> Data {
        let string = "test"
        return Data(base64Encoded: string)!
    }
}

final class BaseWebServiceTests: XCTestCase {

    private let fakeSession = SessionMock()
    private lazy var service = BaseWebService(session: fakeSession)
    private let fakeUrl = URL(string: "www.example.com")!

    func testRequestShouldReturnSuccess_WhenServerReturnSuccess() throws {
        fakeSession.data = BaseWebService.jsonDataSuccess()
        fakeSession.URLResponse = HTTPURLResponse(url: fakeUrl, statusCode: 200,
                                                  httpVersion: "", headerFields: [:])
        let expectation = XCTestExpectation(description: "testSuccess")
        var fakeResult: Result<TestModel, WebServiceError>?
        service.request(path: Path.menu) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch fakeResult {
        case .success(let testModel):
            XCTAssertEqual(testModel.test, "ok")
        default:
            XCTFail("This test should have be success")
        }
    }

    func testRequestShouldReturnTimeout_WhenServerReturnTimeoutError() throws {
        fakeSession.data = BaseWebService.jsonDataSuccess()
        fakeSession.error = NSError(domain: "", code: NSURLErrorTimedOut)
        fakeSession.URLResponse = HTTPURLResponse(url: fakeUrl, statusCode: 200,
                                                  httpVersion: "", headerFields: [:])
        let expectation = XCTestExpectation(description: "testTimeoutError")
        var fakeResult: Result<TestModel, WebServiceError>?
        service.request(path: Path.menu) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch fakeResult {
        case let .failure(error):
            XCTAssertEqual(error, WebServiceError.timedOut)
        default:
            XCTFail("This test should fail")
        }
    }

    func testRequestShouldReturnNotConnectedToInternet_WhenServerReturnNotConnectedToInternetError() throws {
        fakeSession.data = BaseWebService.jsonDataSuccess()
        fakeSession.error = NSError(domain: "", code: NSURLErrorNotConnectedToInternet)
        fakeSession.URLResponse = HTTPURLResponse(url: fakeUrl, statusCode: 200,
                                                  httpVersion: "", headerFields: [:])
        let expectation = XCTestExpectation(description: "testNoInternetError")
        var fakeResult: Result<TestModel, WebServiceError>?
        service.request(path: Path.menu) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch fakeResult {
        case let .failure(error):
            XCTAssertEqual(error, WebServiceError.notConnectedToInternet)
        default:
            XCTFail("This test should fail")
        }
    }

    func testRequestShouldReturnUnexpected_WhenServerReturnAnyOtherError() throws {
        fakeSession.data = BaseWebService.jsonDataSuccess()
        fakeSession.error = NSError(domain: "", code: NSURLErrorBadServerResponse)
        fakeSession.URLResponse = HTTPURLResponse(url: fakeUrl, statusCode: 200,
                                                  httpVersion: "", headerFields: [:])
        let expectation = XCTestExpectation(description: "testAnyError")
        var fakeResult: Result<TestModel, WebServiceError>?
        service.request(path: Path.menu) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch fakeResult {
        case let .failure(error):
            XCTAssertEqual(error, WebServiceError.unexpected)
        default:
            XCTFail("This test should fail")
        }
    }

    func testRequestShouldReturnUnexpected_WhenUrlResponseIsNil() throws {
        fakeSession.data = BaseWebService.jsonDataSuccess()
        let expectation = XCTestExpectation(description: "testUrlResponseError")
        var fakeResult: Result<TestModel, WebServiceError>?
        service.request(path: Path.menu) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch fakeResult {
        case let .failure(error):
            XCTAssertEqual(error, WebServiceError.unexpected)
        default:
            XCTFail("This test should fail")
        }
    }

    func testRequestShouldReturnUnexpected_WhenStatusCodeIsNotBetween200and299() throws {
        fakeSession.data = BaseWebService.jsonDataSuccess()
        fakeSession.URLResponse = HTTPURLResponse(url: fakeUrl, statusCode: 300,
                                                  httpVersion: "", headerFields: [:])
        let expectation = XCTestExpectation(description: "testUrlResponseError")
        var fakeResult: Result<TestModel, WebServiceError>?
        service.request(path: Path.menu) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch fakeResult {
        case let .failure(error):
            XCTAssertEqual(error, WebServiceError.unexpected)
        default:
            XCTFail("This test should fail")
        }
    }

    func testRequestShouldReturnUnexpected_WhenDataIsNil() throws {
        fakeSession.URLResponse = HTTPURLResponse(url: fakeUrl, statusCode: 200,
                                                  httpVersion: "", headerFields: [:])
        let expectation = XCTestExpectation(description: "testUrlDataNilError")
        var fakeResult: Result<TestModel, WebServiceError>?
        service.request(path: Path.menu) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch fakeResult {
        case let .failure(error):
            XCTAssertEqual(error, WebServiceError.unexpected)
        default:
            XCTFail("This test should fail")
        }
    }

    func testRequestShouldReturnUnparsaebleError_WhenServerReturnSuccessWithUnparsaebleJSON() throws {
        fakeSession.data = BaseWebService.notJSONDataSuccess()
        fakeSession.URLResponse = HTTPURLResponse(url: fakeUrl, statusCode: 200,
                                                  httpVersion: "", headerFields: [:])
        let expectation = XCTestExpectation(description: "testUrlUnparsaebleError")
        var fakeResult: Result<TestModel, WebServiceError>?
        service.request(path: Path.menu) {(result: Result<TestModel, WebServiceError>) in
            fakeResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch fakeResult {
        case let .failure(error):
            XCTAssertEqual(error, WebServiceError.unparseable)
        default:
            XCTFail("This test should fail")
        }
    }
}
