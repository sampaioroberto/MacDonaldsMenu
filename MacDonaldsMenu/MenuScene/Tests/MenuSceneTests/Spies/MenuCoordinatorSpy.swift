@testable import MenuScene

final class MenuCoordinatorSpy: MenuCoordinating {
    private(set) var didShowDetailsWithItemCallsCount = 0
    private(set) var item: Item?

    func showModalDetailsWithItem(item: Item) {
        didShowDetailsWithItemCallsCount += 1
        self.item = item
    }
}
