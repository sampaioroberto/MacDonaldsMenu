import UIKit

final class ViewControllerSpy: UIViewController {
    private(set) var didPresentViewControllerCallsCount = 0
    private(set) var viewControllerToPresent: UIViewController?

    override func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil) {
        didPresentViewControllerCallsCount += 1
        self.viewControllerToPresent = viewControllerToPresent
    }
}
