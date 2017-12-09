import UIKit
import SnapKit
import RxSwift

protocol ActivitiesViewControlling: class {
    var viewModels: [DailyReportViewModelProtocol] { get set }
    var navigationItemTitle: String? { get set }
    var viewDidAppear: Observable<Void> { get }
    var isLoading: AnyObserver<Bool> { get }
}

class ActivitiesViewController: UITableViewController, ActivitiesViewControlling {

    init() {
        super.init(style: .plain)
        tableView.register(ReportCell.self, forCellReuseIdentifier: ReportCell.reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.applayHubStyle()
        navigationItem.titleView = navigationItemTitleLabel
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.onNext(())
    }

    // MARK: - ActivitiesViewControlling

    var viewModels: [DailyReportViewModelProtocol] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    var navigationItemTitle: String? {
        didSet {
            navigationItemTitleLabel.text = navigationItemTitle
            navigationItemTitleLabel.sizeToFit()
        }
    }

    var viewDidAppear: Observable<Void> {
        return viewDidAppearSubject.asObservable()
    }

    var isLoading: AnyObserver<Bool> {
        return AnyObserver(eventHandler: { [weak self] event in
            guard let element = event.element else { return }
            self?.loadingIndicator.loading(element)
        })
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        return reportCell(tableView, indexPath: indexPath, viewModel: viewModel)
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Private

    private let viewDidAppearSubject = PublishSubject<Void>()

    func reportCell(_ tableView: UITableView, indexPath: IndexPath, viewModel: DailyReportViewModelProtocol) -> ReportCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReportCell.reuseIdentifier, for: indexPath) as? ReportCell else { fatalError() }
        viewModel.bind(to: cell).disposed(by: cell.reusabilityDisposeBag)
        return cell
    }

    // MARK: - Subviews

    private let navigationItemTitleLabel = NavigationItemSubviews.label

    // MARK: - Loading

    private(set) lazy var loadingIndicator: LoadingIndicator = {
        return LoadingIndicator(superView: self.view)
    }()

}

private extension ActivitiesViewController {

    struct NavigationItemSubviews {
        static var label: UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Helvetica", size: 17)
            label.textColor = .white
            return label
        }
    }

}
