import UIKit

class ViewControllerSpy: UIViewController {

    var didPresentViewController: UIViewController?
    var didDismiss = false

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        didPresentViewController = viewControllerToPresent
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        didDismiss = true
    }

}
