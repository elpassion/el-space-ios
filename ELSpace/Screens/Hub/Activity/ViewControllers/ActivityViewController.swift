import UIKit
import RxSwift
import RxCocoa

protocol ActivityViewControllerAssembly {
    var typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling { get }
    var formViewController: UIViewController & ActivityFormViewControlling { get }
    var notificationCenter: NotificationCenter { get }
    var alertFactory: AlertCreation { get }
    var viewControllerPresenter: ViewControllerPresenting { get }
}

protocol ActivityViewControlling {
    var addActivity: Observable<NewActivityDTO> { get }
    var updateActivity: Observable<NewActivityDTO> { get }
    var deleteAction: Observable<Void> { get }
    var isLoading: AnyObserver<Bool> { get }
    var showError: AnyObserver<Error> { get }
}

enum ActivityType {
    case report(ReportDTO)
    case new(Date)
}

class ActivityViewController: UIViewController, ActivityViewControlling {

    init(activityType: ActivityType,
         assembly: ActivityViewControllerAssembly) {
        self.activityType = activityType
        self.typeChooserViewController = assembly.typeChooserViewController
        self.formViewController = assembly.formViewController
        self.notificationCenter = assembly.notificationCenter
        self.alertFactory = assembly.alertFactory
        self.viewControllerPresenter = assembly.viewControllerPresenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: View

    override func loadView() {
        view = ActivityView()
        loadingIndicator = LoadingIndicator(superView: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSubviews()
        setupBindings()
    }

    // MARK: - ActivityViewControlling

    var addActivity: Observable<NewActivityDTO> {
        return addActivityRelay.asObservable()
    }

    var updateActivity: Observable<NewActivityDTO> {
        return updateActivityRelay.asObservable()
    }

    var deleteAction: Observable<Void> {
        return deleteActionRelay.asObservable()
    }

    var isLoading: AnyObserver<Bool> {
        return AnyObserver(onNext: { [weak self] in self?.loadingIndicator?.loading($0) })
    }

    var showError: AnyObserver<Error> {
        return AnyObserver(onNext: { [weak self] in self?.showError($0) })
    }

    // MARK: - Private

    private let activityType: ActivityType
    private let typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling
    private let formViewController: UIViewController & ActivityFormViewControlling
    private let alertFactory: AlertCreation
    private let viewControllerPresenter: ViewControllerPresenting
    private let deleteButton = UIButton(frame: .zero)
    private let notificationCenter: NotificationCenter
    private let addActivityRelay = PublishRelay<NewActivityDTO>()
    private let updateActivityRelay = PublishRelay<NewActivityDTO>()
    private let deleteActionRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    private var loadingIndicator: LoadingIndicator?
    private let rightItemActionRelay = PublishRelay<Void>()

    private var activityView: ActivityView! {
        return view as? ActivityView
    }

    private func configureNavigationBar() {
        navigationItem.titleView = NavigationItemSubviews.label(activityType: activityType)
        navigationItem.rightBarButtonItem = NavigationItemSubviews.addBarButton(activityType: activityType)
        navigationItem.rightBarButtonItem?.action = #selector(ActivityViewController.rightItemAction)
        navigationItem.rightBarButtonItem?.target = self
    }

    private func configureSubviews() {
        addChild(typeChooserViewController)
        typeChooserViewController.didMove(toParent: self)
        activityView.addView(typeChooserViewController.view)

        addChild(formViewController)
        formViewController.didMove(toParent: self)
        activityView.addView(formViewController.view)

        if case .report(_) = activityType {
            deleteButton.backgroundColor = .red
            deleteButton.setTitle("Delete", for: .normal)
            deleteButton.layer.cornerRadius = 5.0
            activityView.addView(deleteButton)
        }
    }

    private func setupBindings() {
        typeChooserViewController.selected
            .bind(to: formViewController.type)
            .disposed(by: disposeBag)

        Observable.of(notificationCenter.rx.notification(UIResponder.keyboardWillHideNotification),
                      notificationCenter.rx.notification(UIResponder.keyboardWillChangeFrameNotification))
            .merge()
            .subscribe(onNext: { [weak self] in self?.adjustForKeyboard(notification: $0) })
            .disposed(by: disposeBag)

        Observable.combineLatest(formViewController.form,
                                 typeChooserViewController.selected)
            .map { [weak self] in
                guard let `self` = self else { return false }
                let isFormValid = NewActivityDTO.create(with: $0.0, type: $0.1).isValid
                switch self.activityType {
                case .new(_): return isFormValid
                case .report(_): return isFormValid && $0.1 == .normal
                }
            }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in self?.navigationItem.rightBarButtonItem?.isEnabled = $0 })
            .disposed(by: disposeBag)

        rightItemActionRelay
            .flatMap { [weak self] _ -> Observable<NewActivityDTO> in
                guard let `self` = self else { return Observable.never() }
                return Observable.combineLatest(self.formViewController.form, self.typeChooserViewController.selected)
                    .map { NewActivityDTO.create(with: $0.0, type: $0.1) }
                    .take(1) }
            .filter { $0.isValid }
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                switch self.activityType {
                case .new(_): self.addActivityRelay.accept($0)
                case .report(_): self.updateActivityRelay.accept($0)
                }
                })
            .disposed(by: disposeBag)

        deleteButton.rx.controlEvent(.touchUpInside)
            .flatMap { [weak self] _ -> Observable<Void> in
                guard let `self` = self else { return Observable.never() }
                return self.showConfirmDeletion()
            }
            .bind(to: deleteActionRelay)
            .disposed(by: disposeBag)
    }

    private func adjustForKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo, let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardView = view.convert(endFrame, from: view.window)
            let bottomInset = notification.name == UIResponder.keyboardWillHideNotification ? 0 : keyboardView.height
            activityView.scrollView.contentInset = UIEdgeInsets(top: 0,
                                                                left: 0,
                                                                bottom: bottomInset,
                                                                right: 0)
        }
    }

    private func showConfirmDeletion() -> Observable<Void> {
        return Observable.create({ [weak self] observer -> Disposable in
            guard let `self` = self else { return Disposables.create() }
            let alertController = UIAlertController(title: "Confirm report deletion", message: "Are you sure?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in observer.onNext(()) })
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            self.present(alertController, animated: true, completion: nil)
            return Disposables.create()
        })
    }

    private func showError(_ error: Error) {
        let alert = alertFactory.messageAlertController(with: "Communication error", message: error.localizedDescription)
        viewControllerPresenter.present(viewController: alert, on: self)
    }

    @objc func rightItemAction() {
        rightItemActionRelay.accept(())
    }

}

private extension ActivityViewController {

    struct NavigationItemSubviews {
        static func label(activityType: ActivityType) -> UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Gotham-Book", size: 17)
            label.textColor = .white
            switch activityType {
            case .report(_): label.text = "Report"
            case .new(_): label.text = "New activity"
            }
            return label
        }

        static func addBarButton(activityType: ActivityType) -> UIBarButtonItem {
            var title = ""
            switch activityType {
            case .report(_): title = "Update"
            case .new(_): title = "Add"
            }
            let barButton = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
            barButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: "Gotham-Book", size: 17) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.white as Any
            ], for: .normal)
            barButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: "Gotham-Book", size: 17) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.white as Any
            ], for: .highlighted)
            barButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: "Gotham-Book", size: 17) as Any,
                NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.2) as Any
                ], for: .disabled)
            return barButton
        }
    }

}
