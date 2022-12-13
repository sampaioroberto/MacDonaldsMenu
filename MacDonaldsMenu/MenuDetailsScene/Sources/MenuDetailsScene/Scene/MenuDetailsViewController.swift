import UIKit
import UI
import SnapKit
import Kingfisher

extension MenuDetailsViewController.Layout {
    static let titleNumberOfLines = 2
    static let containerBorderWidth: CGFloat = 1.0
}

final class MenuDetailsViewController: UIViewController {
    fileprivate enum Layout { }

    // MARK: - Properties
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .big(weight: .bold)
        label.textColor = .label
        label.numberOfLines = Layout.titleNumberOfLines
        label.textAlignment = .center
        return label
    }()

    private let itemValueContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = Layout.containerBorderWidth
        return view
    }()

    private let itemValueLabel: UILabel = {
        let label = UILabel()
        label.font = .medium()
        label.textColor = .label
        return label
    }()

    private let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .medium()
        label.textColor = .label
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()

    // MARK: - Life Cycle
    init(imageURL: URL, title: String, value: Double, description: String) {
        super.init(nibName: nil, bundle: nil)
        itemImageView.kf.setImage(with: imageURL)
        itemTitleLabel.text = title
        itemValueLabel.text = "$\(value)"
        itemDescriptionLabel.text = description
        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuDetailsViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(itemImageView)
        view.addSubview(itemTitleLabel)
        view.addSubview(itemValueContainerView)
        itemValueContainerView.addSubview(itemValueLabel)
        view.addSubview(itemDescriptionLabel)
    }

    func setupConstraints() {
        itemImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.snp.width)
        }

        itemTitleLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(Spacing.space01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.space01)
        }

        itemValueContainerView.snp.makeConstraints {
            $0.top.equalTo(itemTitleLabel.snp.bottom).offset(Spacing.space01)
            $0.centerX.equalToSuperview()
        }

        itemValueLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Spacing.space00)
        }

        itemDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(itemValueContainerView.snp.bottom).offset(Spacing.space01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.space01)
        }

    }

    func configureViews() {
        itemValueLabel.sizeToFit()
        itemValueContainerView.layer.cornerRadius = itemValueLabel.frame.height/2
        view.backgroundColor = .systemBackground
    }
}
