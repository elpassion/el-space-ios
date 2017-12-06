import UIKit

protocol ViewControllerPresenting {
    func present(viewController: UIViewController, on currentViewController: UIViewController)
    func push(viewController: UIViewController, on currentViewController: UIViewController)
    func push(viewController: UIViewController, on navigationController: UINavigationController)
}

class ViewControllerPresenter: ViewControllerPresenting {

    func present(viewController: UIViewController, on presentViewController: UIViewController) {
        presentViewController.present(viewController, animated: true, completion: nil)
    }

    func push(viewController: UIViewController, on presentViewController: UIViewController) {
        guard let navigationController = presentViewController.navigationController else { return }
        push(viewController: viewController, on: navigationController)
    }

    func push(viewController: UIViewController, on navigationController: UINavigationController) {
        navigationController.pushViewController(viewController, animated: true)
    }

}
