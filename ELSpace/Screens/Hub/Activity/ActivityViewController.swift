import UIKit

class ActivityViewController: UIViewController {

    init() {
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

        let activityTypeViewController = ChooserActivityTypeAssembly().viewController()
        addChildViewController(activityTypeViewController)
        activityTypeViewController.didMove(toParentViewController: self)
        activityView.activityTypeView = activityTypeViewController.view
    }

    // MARK: - Private

    private var activityView: ActivityView! {
        return view as? ActivityView
    }

    private let addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)

}
