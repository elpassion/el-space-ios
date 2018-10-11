import UIKit

extension AppContainer: LoginViewControllerCreation,
                        NavigationControllerCreation,
                        SelectionViewControllerCreation,
                        AlertCreation,
                        ActivitiesViewControllerCreation,
                        ActivityViewControllerCreation,
                        ProjectSearchViewControllerCreation {

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
        return ActivitiesViewController(alertFactory: self,
                                        viewControllerPresenter: viewControllerPresenter)
    }

    // MARK: - ActivityViewControllerCreation

    func activityViewController(activityType: ActivityType, projectScope: [ProjectDTO]) -> UIViewController & ActivityViewControlling {
        return ActivityViewControllerCreator().activityViewController(activityType: activityType,
                                                                      projectScope: projectScope,
                                                                      alertFactory: self,
                                                                      viewControllerPresenter: viewControllerPresenter)
    }

    // MARK: ProjectSearchViewControllerCreation

    func projectSearchViewController(projectId: Int?) -> UIViewController & ProjectSearchViewControlling {
        return ProjectSearchViewController()
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
    func activityViewController(activityType: ActivityType, projectScope: [ProjectDTO]) -> UIViewController & ActivityViewControlling
}

protocol ProjectSearchViewControllerCreation {
    func projectSearchViewController(projectId: Int?) -> UIViewController & ProjectSearchViewControlling
}
