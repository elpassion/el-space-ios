import UIKit

extension AppContainer: LoginViewControllerCreation,
                        NavigationControllerCreation,
                        SelectionViewControllerCreation,
                        AlertCreation,
                        ActivitiesViewControllerCreation,
                        ActivityViewControllerCreation {

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

    // MARK: - ActivitiesViewControllerCreation

    func activitiesViewController() -> UIViewController & ActivitiesViewControlling {
        return ActivitiesViewController()
    }

    // MARK: - ActivityViewControllerCreation

    func activityViewController(report: ReportDTO, projectScope: [ProjectDTO]) -> UIViewController & ActivityViewControlling {
        return ActivityViewControllerCreator().activityViewController(report: report, projectScope: projectScope)
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

protocol ActivitiesViewControllerCreation {
    func activitiesViewController() -> UIViewController & ActivitiesViewControlling
}

protocol AlertCreation {
    func messageAlertController(with title: String?, message: String?) -> UIAlertController
}

protocol ActivityViewControllerCreation {
    func activityViewController(report: ReportDTO, projectScope: [ProjectDTO]) -> UIViewController & ActivityViewControlling
}
