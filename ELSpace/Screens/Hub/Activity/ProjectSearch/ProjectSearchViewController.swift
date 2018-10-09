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

}
