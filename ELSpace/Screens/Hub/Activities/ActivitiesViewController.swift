import UIKit
import RxCocoa
import RxSwift

protocol ActivitiesViewControlling: class {
    var viewModels: [DailyReportViewModelProtocol] { get set }
    var navigationItemTitle: String? { get set }
    var viewDidAppear: Observable<Void> { get }
    var changeMonth: Driver<Void> { get }
    var isLoading: AnyObserver<Bool> { get }
    var error: AnyObserver<Error> { get }
}

class ActivitiesViewController: UIViewController, ActivitiesViewControlling {

    init(alertFactory: AlertCreation,
         viewControllerPresenter: ViewControllerPresenting) {
        self.alertFactory = alertFactory
        self.viewControllerPresenter = viewControllerPresenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMonthChanger()
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

    var changeMonth: Driver<Void> {
        return changeMonthRelay.asDriver(onErrorDriveWith: .never())
    }

    var isLoading: AnyObserver<Bool> {
        return AnyObserver(onNext: { [weak self] in
            self?.loadingIndicator.loading($0)
        })
    }

    var error: AnyObserver<Error> {
        return AnyObserver(onNext: { [weak self] in self?.presentError(error: $0) })
    }

    // MARK: - Private

    private let alertFactory: AlertCreation
    private let viewControllerPresenter: ViewControllerPresenting

    private let viewDidAppearSubject = PublishSubject<Void>()
    private let addActivitySubject = PublishSubject<Void>()
    private let changeMonthRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()

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

    private func configureMonthChanger() {
        let tap = UITapGestureRecognizer()
        navigationItemTitleLabel.isUserInteractionEnabled = true
        navigationItemTitleLabel.addGestureRecognizer(tap)
        tap.rx.event
            .map { _ in }
            .bind(to: changeMonthRelay)
            .disposed(by: disposeBag)
    }

    // MARK: - Error presenting

    private func presentError(error: Error) {
        let alert = alertFactory.messageAlertController(with: "Error", message: error.localizedDescription)
        viewControllerPresenter.present(viewController: alert, on: self)
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
