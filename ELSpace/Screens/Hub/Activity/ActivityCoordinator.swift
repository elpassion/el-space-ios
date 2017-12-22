import UIKit

class ActivityCoordinator: Coordinator {

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // MARK: Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: Private

    private let viewController: UIViewController

}
