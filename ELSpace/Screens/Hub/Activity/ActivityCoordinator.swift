import UIKit

class ActivityCoordinator: Coordinator {

    init(viewController: UIViewController & ActivityViewControlling) {
        self.viewController = viewController
    }

    // MARK: Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: Private

    private let viewController: UIViewController & ActivityViewControlling

}
