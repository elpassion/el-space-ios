@testable import ELSpace
import UIKit

class ModalViewControllerPresenterSpy: ModalViewControllerPresenting {

    // MARK: - ModalViewControllerPresenting

    func present(viewController: UIViewController, on baseViewController: UIViewController) {
        presentedViewControllerSpy = viewController
        baseViewControllerSpy = baseViewController
    }

    func dismiss(viewController: UIViewController) {
        dismissedViewControllerSpy = viewController
    }

    // MARK: - Spies

    var presentedViewControllerSpy: UIViewController?
    var baseViewControllerSpy: UIViewController?
    var dismissedViewControllerSpy: UIViewController?

}
