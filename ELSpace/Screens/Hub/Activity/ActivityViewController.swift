import UIKit
import RxSwift

protocol ActivityViewControllerAssembly {
    var chooserActivityTypeViewController: UIViewController & ChooserActivityTypesViewControlling { get }
    var activityFormViewController: UIViewController & ActivityFormViewControlling { get }
}

class ActivityViewController: UIViewController {

    init(assembly: ActivityViewControllerAssembly) {
        self.chooserActivityTypeViewController = assembly.chooserActivityTypeViewController
        self.activityFormViewController = assembly.activityFormViewController
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
        navigationItem.title = "New activity"
        navigationItem.rightBarButtonItem = addBarButton
        configureChooserType()
        configureForm()
        setupBindings()
    }

    // MARK: - Private

    private let chooserActivityTypeViewController: UIViewController & ChooserActivityTypesViewControlling
    private let activityFormViewController: UIViewController & ActivityFormViewControlling
    private let disposeBag = DisposeBag()

    private var activityView: ActivityView! {
        return view as? ActivityView
    }

    private let addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)

    private func configureChooserType() {
        addChildViewController(chooserActivityTypeViewController)
        chooserActivityTypeViewController.didMove(toParentViewController: self)
        activityView.activityTypeView = chooserActivityTypeViewController.view
    }

    private func configureForm() {
        addChildViewController(activityFormViewController)
        activityFormViewController.didMove(toParentViewController: self)
        activityView.activityFormView = activityFormViewController.view
    }

    private func setupBindings() {
        chooserActivityTypeViewController.selected
            .bind(to: activityFormViewController.type)
            .disposed(by: disposeBag)
    }

}
