import UIKit

protocol ActivityViewControllerAssembly {
    var chooserActivityTypeViewController: UIViewController & ChooserActivityTypesViewControlling { get }
}

class ActivityViewController: UIViewController {

    init(assembly: ActivityViewControllerAssembly) {
        self.chooserActivityTypeViewController = assembly.chooserActivityTypeViewController
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
        navigationItem.titleView = NavigationItemSubviews.label
        navigationItem.rightBarButtonItem = NavigationItemSubviews.addBarButton
        configureChooserType()
    }

    // MARK: - Private

    private let chooserActivityTypeViewController: UIViewController & ChooserActivityTypesViewControlling

    private var activityView: ActivityView! {
        return view as? ActivityView
    }

    private func configureChooserType() {
        addChildViewController(chooserActivityTypeViewController)
        chooserActivityTypeViewController.didMove(toParentViewController: self)
        activityView.activityTypeView = chooserActivityTypeViewController.view
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
                NSAttributedStringKey.font: UIFont(name: "Gotham-Book", size: 17) ?? UIFont.systemFont(ofSize: 17)
            ], for: .normal)
            barButton.setTitleTextAttributes([
                NSAttributedStringKey.font: UIFont(name: "Gotham-Book", size: 17) ?? UIFont.systemFont(ofSize: 17)
            ], for: .highlighted)
            return barButton
        }
    }

}
