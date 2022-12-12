@testable import MenuScene
import Network
import XCTest

final class MenuInteractorTests: XCTestCase {
    // MARK: - Variables
    private let presenter = MenuPresenterSpy()
    private let service = MenuServiceMock()

    private lazy var interactor = MenuInteractor(presenter: presenter, service: service)

    // MARK: - fetchPosts
    func testFetchMenu_WhenAllServicesReturnsSuccess_ShouldCallLoadingAndPresentMenu() {
        service.menuResult = .success(MockConstants.menu)

        interactor.fetchMenu()

        XCTAssertEqual(self.presenter.didPresentLoadingCallsCount, 1)
        XCTAssertEqual(self.presenter.didPresentMenuCallsCount, 1)
        XCTAssertEqual(self.presenter.menu, MockConstants.menu)
    }

    func testFetchMenu_WhenServiceReturnsSuccessWithEmpty_ShouldCallPresentErrorWithEmpty() {
        service.menuResult = .success(Menu(menus: []))

        interactor.fetchMenu()
        XCTAssertEqual(self.presenter.didPresentErrorCallsCount, 1)
        XCTAssertEqual(self.presenter.type, .empty)
    }

    func testFetchMenu_WhenServiceReturnsUnexpectedFailure_ShouldCallPresentErrorWithUnexpected() {
        service.menuResult = .failure(.unexpected)

        interactor.fetchMenu()

        XCTAssertEqual(self.presenter.didPresentErrorCallsCount, 1)
        XCTAssertEqual(self.presenter.type, .unexpected)
    }
}
