import UIKit
import RxSwift
import RxCocoa

protocol ActivityViewControllerAssembly {
    var typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling { get }
    var formViewController: UIViewController & ActivityFormViewControlling { get }
    var notificationCenter: NotificationCenter { get }
}

protocol ActivityViewControlling {
    var addActivity: Observable<NewActivityDTO> { get }
    var deleteAction: Observable<Void> { get }
    var isLoading: AnyObserver<Bool> { get }
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
        return Observable.empty()
    }

    var deleteAction: Observable<Void> {
        return deleteActionRelay.asObservable()
    }

    var isLoading: AnyObserver<Bool> {
        return AnyObserver(onNext: { [weak self] in self?.loadingIndicator?.loading($0) })
    }

    // MARK: - Private

    private let activityType: ActivityType
    private let typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling
    private let formViewController: UIViewController & ActivityFormViewControlling
    private let deleteButton = UIButton(frame: .zero)
    private let notificationCenter: NotificationCenter
    private let deleteActionRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    private var loadingIndicator: LoadingIndicator?

    private var activityView: ActivityView! {
        return view as? ActivityView
    }

    private func configureNavigationBar() {
        navigationItem.titleView = NavigationItemSubviews.label(activityType: activityType)
        navigationItem.rightBarButtonItem = NavigationItemSubviews.addBarButton(activityType: activityType)
    }

    private func configureSubviews() {
        addChildViewController(typeChooserViewController)
        typeChooserViewController.didMove(toParentViewController: self)
        activityView.addView(typeChooserViewController.view)

        addChildViewController(formViewController)
        formViewController.didMove(toParentViewController: self)
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

        Observable.of(notificationCenter.rx.notification(Notification.Name.UIKeyboardWillHide),
                      notificationCenter.rx.notification(Notification.Name.UIKeyboardWillChangeFrame))
            .merge()
            .subscribe(onNext: { [weak self] in self?.adjustForKeyboard(notification: $0) })
            .disposed(by: disposeBag)

        formViewController.form
            .subscribe(onNext: {
                print("project: \($0.project ?? ""), hours: \($0.hours ?? 0), comment: \($0.comment ?? "")")
            }).disposed(by: disposeBag)

        deleteButton.rx.controlEvent(.touchUpInside)
            .flatMap { [weak self] _ -> Observable<Void> in
                guard let `self` = self else { return Observable.never() }
                return self.showConfirmDeletion()
            }
            .bind(to: deleteActionRelay)
            .disposed(by: disposeBag)

    }

    private func adjustForKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo, let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardView = view.convert(endFrame, from: view.window)
            let bottomInset = notification.name == Notification.Name.UIKeyboardWillHide ? 0 : keyboardView.height
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
                NSAttributedStringKey.font: UIFont(name: "Gotham-Book", size: 17) as Any
            ], for: .normal)
            barButton.setTitleTextAttributes([
                NSAttributedStringKey.font: UIFont(name: "Gotham-Book", size: 17) as Any
            ], for: .highlighted)
            return barButton
        }
    }

}
