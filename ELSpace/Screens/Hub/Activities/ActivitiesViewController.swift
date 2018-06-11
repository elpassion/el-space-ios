import UIKit
import RxSwift

protocol ActivitiesViewControlling: class {
    var viewModels: [DailyReportViewModelProtocol] { get set }
    var navigationItemTitle: String? { get set }
    var viewDidAppear: Observable<Void> { get }
    var isLoading: AnyObserver<Bool> { get }
}

class ActivitiesViewController: UIViewController, ActivitiesViewControlling {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.applyHubStyle()
        navigationItem.titleView = navigationItemTitleLabel
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.onNext(())
    }

    var activitiesView: ActivitiesView! {
        return view as? ActivitiesView
    }

    override func loadView() {
        view = ActivitiesView()
    }

    // MARK: - ActivitiesViewControlling

    var viewModels: [DailyReportViewModelProtocol] = [] {
        didSet {
            setDailyReports()
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
        return AnyObserver(onNext: { [weak self] in
            self?.loadingIndicator.loading($0)
        })
    }

    // MARK: - Private

    private let viewDidAppearSubject = PublishSubject<Void>()
    private let addActivitySubject = PublishSubject<Void>()

    private func setDailyReports() {
        activitiesView.stackView.arrangedSubviews.forEach {
            activitiesView.stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        let views = viewModels.map { viewModel -> ReportView in
            let view = ReportView()
            bind(viewModel: viewModel, to: view).disposed(by: viewModel.disposeBag)
            return view
        }
        views.forEach { activitiesView.stackView.addArrangedSubview($0) }
    }

    // MARK: - Subviews

    private let navigationItemTitleLabel = NavigationItemSubviews.label

    // MARK: - Loading

    private lazy var loadingIndicator: LoadingIndicator = {
        return LoadingIndicator(superView: self.view)
    }()

}

private extension ActivitiesViewController {

    struct NavigationItemSubviews {
        static var label: UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Gotham-Medium", size: 17)
            label.textColor = .white
            return label
        }
    }

}
