import UIKit

class AppCoordinator: Coordinator {

    init(navigationController: UINavigationController,
         loginViewController: LoginViewControlling,
         selectionCoordinatorFactory: SelectionCoordinatorCreation,
         viewControllerPresenter: ViewControllerPresenting) {
        self.navigationController = navigationController
        self.selectionCoordinatorFactory = selectionCoordinatorFactory
        self.viewControllerPresenter = viewControllerPresenter
        self.loginViewController = loginViewController
        self.loginViewController.googleTooken = { [weak self] token in
            self?.presentSelectionController(googleTokenId: token)
        }
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return navigationController
    }

    // MARK: - Private

    private let navigationController: UINavigationController
    private var loginViewController: LoginViewControlling
    private let selectionCoordinatorFactory: SelectionCoordinatorCreation
    private let viewControllerPresenter: ViewControllerPresenting

    // MARK: - Presenting

    private var presentedCoordinator: Coordinator?

    private func presentSelectionController(googleTokenId: String) {
        let coordinator = selectionCoordinatorFactory.selectionCoordinator(googleIdToken: googleTokenId)
        self.presentedCoordinator = coordinator
        viewControllerPresenter.push(viewController: coordinator.initialViewController, on: navigationController)
    }

}
