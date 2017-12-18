import UIKit

class UIViewControllerSpy: UIViewController {

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.viewControllerToPresent = viewControllerToPresent
        presentedWithAnimation = flag
    }

    // MARK: - Spies

    var viewControllerToPresent: UIViewController?
    var presentedWithAnimation: Bool?

}
