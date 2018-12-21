@testable import ELSpace
import UIKit

class ModalViewControllerPresenterSpy: ModalViewControllerPresenting {

    // MARK: - ModalViewControllerPresenting

    func present(viewController: UIViewController, on baseViewController: UIViewController) {
        presentedViewController = viewController
        self.baseViewController = baseViewController
    }

    func dismiss(viewController: UIViewController) {
        dismissedViewController = viewController
    }

    // MARK: - Spies

    private(set) var presentedViewController: UIViewController?
    private(set) var baseViewController: UIViewController?
    private(set) var dismissedViewController: UIViewController?

}
