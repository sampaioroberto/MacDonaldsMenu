import UIKit
import UI
import Kingfisher
import SnapKit

extension ItemCollectionViewCell.Layout {
    static let numberOfLines = 2
    static let borderWidth: CGFloat = 1
}

enum ItemCollectionViewCellIdentifier {
    static let imageView = "ItemImageView"
    static let title = "ItemTitle"
}

final class ItemCollectionViewCell: UICollectionViewCell {
    typealias Identifier = ItemCollectionViewCellIdentifier

    fileprivate enum Layout { }

    // MARK: - Public functions
    func configure(item: Item, pictureSize: CGFloat) {
        itemLabel.text = item.name
        itemImageView.kf.setImage(with: item.url)
        itemImageView.snp.makeConstraints {
            $0.size.equalTo(pictureSize)
        }
        setIdentifiersWithName(item.name)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let itemLabel: UILabel = {
        let label = UILabel()
        label.font = .medium()
        label.textColor = .label
        label.numberOfLines = Layout.numberOfLines
        return label
    }()
}

// MARK: - View Configuration
extension ItemCollectionViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(itemLabel)
        contentView.addSubview(itemImageView)
    }

    func setupConstraints() {
        itemImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Spacing.space00)
            $0.centerX.equalToSuperview()
        }
        itemLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(Spacing.space01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.space00)
        }
    }

    func configureViews() {
        contentView.layer.borderColor = UIColor.systemGray.cgColor
        contentView.layer.borderWidth = Layout.borderWidth
    }
}

private extension ItemCollectionViewCell {
    func setIdentifiersWithName(_ name: String) {
        itemImageView.accessibilityIdentifier = "\(Identifier.imageView) \(name)"
        itemLabel.accessibilityIdentifier = "\(Identifier.title) \(name)"
    }
}
