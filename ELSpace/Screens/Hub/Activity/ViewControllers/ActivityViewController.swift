import UIKit
import RxSwift

protocol ActivityViewControlling {
    var addAction: Observable<Void> { get }
    var isLoading: AnyObserver<Bool> { get }
}

class ActivityViewController: UIViewController, ActivityViewControlling {

    init(chooserActivityTypeViewController: UIViewController & ChooserActivityTypesViewControlling) {
        self.chooserActivityTypeViewController = chooserActivityTypeViewController
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
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
        navigationItem.title = "New activity"
        navigationItem.rightBarButtonItem = addBarButton
        configureChooserType()
    }

    private var loadingIndicator: LoadingIndicator?

    // MARK: - ActivityViewControlling

    var addAction: Observable<Void> {
        return addBarButton.rx.tap.asObservable()
    }

    var isLoading: AnyObserver<Bool> {
        return AnyObserver(onNext: { [weak self] in self?.loadingIndicator?.loading($0) })
    }

    // MARK: - Private

    private let chooserActivityTypeViewController: UIViewController & ChooserActivityTypesViewControlling

    private var activityView: ActivityView! {
        return view as? ActivityView
    }

    private let addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)

    private func configureChooserType() {
        addChildViewController(chooserActivityTypeViewController)
        chooserActivityTypeViewController.didMove(toParentViewController: self)
        activityView.activityTypeView = chooserActivityTypeViewController.view
    }

}
