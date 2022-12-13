import UIKit

open class ViewController<Interactor>: UIViewController, ViewConfiguration {
    public let interactor: Interactor

    public init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        buildLayout()
    }

    open func buildViewHierarchy() { }

    open func setupConstraints() { }

    open func configureViews() { }
}
