import UIKit
import RxSwift

protocol ActivityViewControllerAssembly {
    var typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling { get }
    var formViewController: UIViewController & ActivityFormViewControlling { get }
    var notificationCenter: NotificationCenter { get }
}

protocol ActivityViewControlling {
    var addAction: Observable<Void> { get }
    var isLoading: AnyObserver<Bool> { get }
    var type: ActivityViewController.`Type` { get set }
}

class ActivityViewController: UIViewController, ActivityViewControlling {

    enum `Type` {
        case add, update
    }

    init(assembly: ActivityViewControllerAssembly) {
        self.typeChooserViewController = assembly.typeChooserViewController
        self.formViewController = assembly.formViewController
        self.notificationCenter = assembly.notificationCenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    // TODO
    var addAction: Observable<Void> {
        return Observable.empty()
//        return addBarButton.rx.tap.asObservable()
    }

    var isLoading: AnyObserver<Bool> {
        return AnyObserver(onNext: { [weak self] in self?.loadingIndicator?.loading($0) })
    }

    var type: `Type` = .add {
        didSet {
            addBarButton.title = type == .add ? "Add" : "Update"
        }
    }

    // MARK: - Private

    private let typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling
    private let formViewController: UIViewController & ActivityFormViewControlling
    private let notificationCenter: NotificationCenter
    private let disposeBag = DisposeBag()

    private let addBarButton = NavigationItemSubviews.addBarButton
    private var loadingIndicator: LoadingIndicator?

    private var activityView: ActivityView! {
        return view as? ActivityView
    }

    private func configureNavigationBar() {
        navigationItem.titleView = NavigationItemSubviews.label
        navigationItem.rightBarButtonItem = addBarButton
    }

    private func configureSubviews() {
        addChildViewController(typeChooserViewController)
        typeChooserViewController.didMove(toParentViewController: self)
        activityView.addView(typeChooserViewController.view)

        addChildViewController(formViewController)
        formViewController.didMove(toParentViewController: self)
        activityView.addView(formViewController.view)
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

}

private extension ActivityViewController {

    struct NavigationItemSubviews {
        static var label: UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Gotham-Book", size: 17)
            label.textColor = .white
            label.text = "New activity"
            return label
        }

        static var addBarButton: UIBarButtonItem {
            let barButton = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)
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
