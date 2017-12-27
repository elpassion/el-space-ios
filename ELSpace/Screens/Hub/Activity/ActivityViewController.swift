import UIKit
import RxSwift

protocol ActivityViewControllerAssembly {
    var typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling { get }
    var formViewController: UIViewController & ActivityFormViewControlling { get }
    var notificationCenter: NotificationCenter { get }
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

    override func loadView() {
        view = ActivityView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSubviews()
        setupBindings()
    }

    // MARK: - ActivityViewControlling

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

    private var activityView: ActivityView! {
        return view as? ActivityView
    }

    private let addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)

    private func configureNavigationBar() {
        navigationItem.title = "New activity"
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

        formViewController.date.onNext(Date())

        formViewController.form
            .subscribe(onNext: { print("project: \($0.project), hours: \($0.hours), comment: \($0.comment)") })
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

}
