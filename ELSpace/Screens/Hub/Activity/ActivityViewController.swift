import UIKit
import RxSwift

protocol ActivityViewControllerAssembly {
    var typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling { get }
    var formViewController: UIViewController & ActivityFormViewControlling { get }
}

class ActivityViewController: UIViewController {

    init(assembly: ActivityViewControllerAssembly) {
        self.typeChooserViewController = assembly.typeChooserViewController
        self.formViewController = assembly.formViewController
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
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

    // MARK: - Private

    private let typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling
    private let formViewController: UIViewController & ActivityFormViewControlling
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
    }

}
