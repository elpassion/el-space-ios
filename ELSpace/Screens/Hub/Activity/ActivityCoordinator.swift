import UIKit

class ActivityCoordinator: Coordinator {

    init(viewController: ActivityViewController) {
        self.viewController = viewController
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: - Private

    private let viewController: ActivityViewController

}
