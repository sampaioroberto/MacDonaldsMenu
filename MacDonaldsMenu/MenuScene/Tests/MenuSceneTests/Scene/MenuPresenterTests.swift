@testable import MenuScene
import XCTest

final class MenuPresenterTests: XCTestCase {
    // MARK: - Variables
    private let viewController = MenuViewControllerSpy()

    private lazy var presenter: MenuPresenter = {
        let presenter = MenuPresenter()
        presenter.viewController = viewController
        return presenter
    }()

    // MARK: - presentMenu
    func testPresentMenu_ShouldCallPresentItemLists() throws {
        presenter.presentMenu(MockConstants.menu)
        let itemLists = try XCTUnwrap(viewController.itemLists)

        XCTAssertEqual(viewController.didDisplayMenuCallsCount, 1)
        XCTAssertEqual(MockConstants.menu.menus, itemLists)
    }

    // MARK: - presentLoading
    func testPresentLoading_ShouldCallDisplayLoading() throws {
        presenter.presentLoading()
        XCTAssertEqual(viewController.didDisplayLoadingCallsCount, 1)
    }

    // MARK: - presentError
    func testPresentError_ShouldCallDisplayErrorWithTitleAndMessage() throws {
        presenter.presentError(type: .unexpected)
        XCTAssertEqual(viewController.didDisplayErrorCallsCount, 1)
        XCTAssertEqual(viewController.title, RequestErrorType.unexpected.title)
        XCTAssertEqual(viewController.message, RequestErrorType.unexpected.description)
    }
}
