import UIKit

class UINavigationControllerSpy: UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        pushedWithAnimation = animated
        super.pushViewController(viewController, animated: animated)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        popedWithAnimation = animated
        return super.popViewController(animated: animated)
    }

    // MARK: - Spies

    var pushedViewController: UIViewController?
    var pushedWithAnimation: Bool?
    var popedWithAnimation: Bool?

}
