import UIKit
import UI
import SnapKit

protocol MenuDisplay: AnyObject {
    func displayItemLists(_ itemList: [ItemList])
    func displayLoading()
    func displayError(title: String, message: String)

}

extension MenuViewController.Layout {
    static let collectionViewInset = 20.0
    static let headerFractionalWidth = 1.0
    static let headerEstimatedHeight = 44.0
}

final class MenuViewController: ViewController<MenuInteracting> {
    fileprivate enum Layout { }
    enum Section {
        case main
    }

    typealias DataSource = UICollectionViewDiffableDataSource<String, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, Item>

    var screenWidth: CGFloat {
        view.frame.width
    }

    // MARK: - Properties
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView,
                                    cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ItemCollectionViewCell.self),
                for: indexPath) as? ItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(item: item, pictureSize: self.screenWidth/3)
            return cell
        })

        dataSource.supplementaryViewProvider = {(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in

          guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: ItemHeaderView.self),
            for: indexPath) as? ItemHeaderView else { fatalError("Cannot create header view") }

            supplementaryView.text = dataSource.sectionIdentifier(for: indexPath.section)
          return supplementaryView
        }
        return dataSource
    }()

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ItemCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: ItemCollectionViewCell.self))
        collectionView.register(ItemHeaderView.self,
                                forSupplementaryViewOfKind: String(describing: ItemHeaderView.self),
                                withReuseIdentifier: String(describing: ItemHeaderView.self))
        interactor.fetchMenu()
    }

    // MARK: - View Configuration
    override func buildViewHierarchy() {
        view.addSubview(collectionView)
    }

    override func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func configureViews() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .secondarySystemGroupedBackground
    }
}

// MARK: - Display
extension MenuViewController: MenuDisplay {
    func displayItemLists(_ itemLists: [ItemList]) {
        collectionView.backgroundView = nil

        var snapshot = Snapshot()
        itemLists.forEach {
            snapshot.appendSections([$0.name])
            snapshot.appendItems($0.items, toSection: $0.name)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.accessibilityIdentifier = String(describing: UIActivityIndicatorView.self)
        activityIndicator.startAnimating()
        collectionView.backgroundView = activityIndicator
    }

    func displayError(title: String, message: String) {
        showErrorView(title: title, message: message) { [weak self] in
            self?.interactor.fetchMenu()
        }
    }
}

private extension MenuViewController {
    func showErrorView(title: String, message: String, tryAgainClosure: (() -> Void)? = nil) {
        let containerView = UIView()
        let errorView = ErrorView(errorTitle: title, errorMessage: message, tryAgainClosure: tryAgainClosure)

        containerView.addSubview(errorView)

        collectionView.backgroundView = containerView

        containerView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        errorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let size = self.screenWidth/2

            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(size), heightDimension: .absolute(size))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(size + Spacing.space02),
                heightDimension: .absolute(size + Spacing.space02))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            group.contentInsets = NSDirectionalEdgeInsets(
                top: Layout.collectionViewInset,
                leading: Layout.collectionViewInset,
                bottom: Layout.collectionViewInset,
                trailing: Layout.collectionViewInset)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Layout.headerFractionalWidth),
                                                    heightDimension: .estimated(Layout.headerEstimatedHeight))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
              layoutSize: headerSize,
              elementKind: String(describing: ItemHeaderView.self), alignment: .top)

            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [sectionHeader]
            section.orthogonalScrollingBehavior = .groupPaging

            return section
        }
        return layout
    }
}
