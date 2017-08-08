import UIKit

extension AppContainer: LoginViewControllerCreation,
                        NavigationControllerCreation,
                        SelectionViewControllerCreation,
                        AlertCreation,
                        ActivityViewControllerCreation {

    var reportsTableViewController: ReportsTableViewController {
        return ReportsTableViewController()
    }

    // MARK: - LoginViewControllerCreation

    func loginViewController() -> LoginViewController {
        return LoginViewController(googleUserManager: googleUserManager,
                                   alertFactory: self,
                                   viewControllerPresenter: viewControllerPresenter,
                                   googleUserMapper: googleUserMapper)
    }

    // MARK: - NavigationControllerCreation

    func navigationController(rootViewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController)
    }

    // MARK: - SelectionViewControllerCreation

    func selectionViewController(googleIdToken: String) -> SelectionViewController {
        return SelectionViewController(selectionController: selectionController(googleIdToken: googleIdToken),
                                       alertFactory: self,
                                       viewControllerPresenter: viewControllerPresenter)
    }

    // MARK: - AlertCreation

    func messageAlertController(with title: String?, message: String?) -> UIAlertController {
        return UIAlertController.simpleAlertViewController(with: title, message: message)
    }

    // MARK: - ActivityViewControllerCreation

    func activityViewController() -> ActivityViewController {
        return ActivityViewController(reportsTableViewController: reportsTableViewController)
    }

}

protocol LoginViewControllerCreation {
    func loginViewController() -> LoginViewController
}

protocol NavigationControllerCreation {
    func navigationController(rootViewController: UIViewController) -> UINavigationController
}

protocol SelectionViewControllerCreation {
    func selectionViewController(googleIdToken: String) -> SelectionViewController
}

protocol ActivityViewControllerCreation {
    func activityViewController() -> ActivityViewController
}

protocol AlertCreation {
    func messageAlertController(with title: String?, message: String?) -> UIAlertController
}
