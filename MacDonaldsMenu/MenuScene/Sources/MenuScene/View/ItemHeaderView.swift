import UIKit
import UI
import SnapKit

final class ItemHeaderView: UICollectionReusableView {

    var text: String? {
        get {
            label.text
        }
        set {
            label.text = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private let label: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.font = .veryBig(weight: .bold)
        return view
    }()
}

extension ItemHeaderView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(label)
    }

    func setupConstraints() {
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Spacing.space01)
            $0.leading.equalToSuperview().offset(Spacing.space01)
        }
    }
}
