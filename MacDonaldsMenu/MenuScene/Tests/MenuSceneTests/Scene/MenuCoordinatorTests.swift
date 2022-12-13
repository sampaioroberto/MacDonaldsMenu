@testable import MenuScene
@testable import MenuDetailsScene
import XCTest

final class MenuCoordinatorTests: XCTestCase {
    // MARK: - Variables

    private let viewController = ViewControllerSpy(nibName: nil, bundle: nil)

    private lazy var coordinator: MenuCoordinator = {
        let coordinator = MenuCoordinator()
        coordinator.viewController = viewController
        return coordinator
    }()

    // MARK: - fetchPosts
    func testShowModalDetailsWithItem_ShouldPresentViewController() throws {
        coordinator.showModalDetailsWithItem(item: MockConstants.item)
        XCTAssertEqual(self.viewController.didPresentViewControllerCallsCount, 1)

        let viewControllerToPresent = try XCTUnwrap(viewController.viewControllerToPresent)

        XCTAssertTrue(viewControllerToPresent.isKind(of: MenuDetailsViewController.self))
    }
}
