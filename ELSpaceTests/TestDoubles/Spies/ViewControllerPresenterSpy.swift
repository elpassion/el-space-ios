@testable import ELSpace

import UIKit

class ViewControllerPresenterSpy: ViewControllerPresenting {

    private(set) var presenter: UIViewController?
    private(set) var presentedViewController: UIViewController?
    private(set) var pushedViewController: UIViewController?

    // MARK: - ViewControllerPresenting

    func present(viewController: UIViewController, on currentViewController: UIViewController) {
        self.presentedViewController = viewController
        self.presenter = currentViewController
    }

    func push(viewController: UIViewController, on currentViewController: UIViewController) {
        self.pushedViewController = viewController
        self.presenter = currentViewController
    }

    func push(viewController: UIViewController, on navigationController: UINavigationController) {
        self.pushedViewController = viewController
        self.presenter = navigationController
    }

}
