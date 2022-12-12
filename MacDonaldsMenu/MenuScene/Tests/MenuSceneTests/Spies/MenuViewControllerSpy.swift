@testable import MenuScene

final class MenuViewControllerSpy: MenuDisplay {
    private(set) var didDisplayMenuCallsCount = 0
    private(set) var itemLists: [ItemList]?
    func displayItemLists(_ itemLists: [ItemList]) {
        didDisplayMenuCallsCount += 1
        self.itemLists = itemLists
    }

    private(set) var didDisplayLoadingCallsCount = 0
    func displayLoading() {
        didDisplayLoadingCallsCount += 1
    }

    private(set) var didDisplayErrorCallsCount = 0
    private(set) var title: String?
    private(set) var message: String?
    func displayError(title: String, message: String) {
        didDisplayErrorCallsCount += 1
        self.title = title
        self.message = message
    }

    var viewController: MenuDisplay?
}
