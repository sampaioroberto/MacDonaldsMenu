import UIKit
import SnapKit

extension ErrorView.Layout {
    static let numberOfLines = 0
    static let buttonCornerRadius = 16.0
    static let buttonBorderWidth: CGFloat = 1.0
    static let cryLabelFontSize: CGFloat = 96.0
}

enum ErrorViewIdentifier {
    static let title = "ErrorViewTitle"
    static let description = "ErrorViewDescription"
}

public final class ErrorView: UIView {
    typealias Identifier = ErrorViewIdentifier

    fileprivate enum Layout { }

    // MARK: - Properties
    private let tryAgainClosure: (() -> Void)?

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Spacing.space01
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .big(weight: .heavy)
        label.textColor = .label
        label.numberOfLines = Layout.numberOfLines
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .medium()
        label.textColor = .label
        label.numberOfLines = Layout.numberOfLines
        label.textAlignment = .center
        return label
    }()

    private let cryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Layout.cryLabelFontSize)
        label.textAlignment = .center
        label.text = "😭"
        return label
    }()

    private lazy var errorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Layout.buttonCornerRadius
        button.layer.borderWidth = Layout.buttonBorderWidth
        button.backgroundColor = .systemGray
        button.setTitle("Try again", for: .normal)
        button.titleLabel?.font = .small()
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        return button
    }()

    // MARK: - Lyfe Cycle
    public init(frame: CGRect = .zero,
                errorTitle: String,
                errorMessage: String,
                tryAgainClosure: (() -> Void)? = nil
    ) {
        self.tryAgainClosure = tryAgainClosure
        super.init(frame: frame)
        titleLabel.text = errorTitle
        descriptionLabel.text = errorMessage
        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Configuration
extension ErrorView: ViewConfiguration {
    // MARK: - View Configuration
    public func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(errorButton)
        stackView.addArrangedSubview(cryLabel)
    }

    public func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    public func configureViews() {
        setIdentifiers()
    }
}

// MARK: - Private functions
private extension ErrorView {
    @objc func tryAgain() {
        tryAgainClosure?()
    }

    func setIdentifiers() {
        titleLabel.accessibilityIdentifier = Identifier.title
        descriptionLabel.accessibilityIdentifier = Identifier.description
    }
}
