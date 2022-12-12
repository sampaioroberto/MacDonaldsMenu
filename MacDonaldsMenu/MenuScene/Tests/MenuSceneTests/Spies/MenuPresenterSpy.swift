@testable import MenuScene

final class MenuPresenterSpy: MenuPresenting {
    private(set) var didPresentMenuCallsCount = 0
    private(set) var menu: Menu?

    func presentMenu(_ menu: Menu) {
        didPresentMenuCallsCount += 1
        self.menu = menu
    }

    private(set) var didPresentLoadingCallsCount = 0
    func presentLoading() {
        didPresentLoadingCallsCount += 1
    }

    private(set) var didPresentErrorCallsCount = 0
    private(set) var type: RequestErrorType?
    func presentError(type: RequestErrorType) {
        didPresentErrorCallsCount += 1
        self.type = type
    }

    var viewController: MenuDisplay?
}
