import UIKit

protocol ProjectSearchViewControlling {

}

class ProjectSearchViewController: UIViewController, ProjectSearchViewControlling {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: View

    override func loadView() {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        self.view = view
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
    }

    // MARK: Privates

    private func setupNavBar() {
        navigationItem.titleView = NavBarItemsFactory.titleView()
    }

}

extension ProjectSearchViewController {
    struct NavBarItemsFactory {
        static func titleView() -> UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Gotham-Book", size: 17)
            label.textColor = .white
            label.text = "Project"
            return label
        }
    }
}
