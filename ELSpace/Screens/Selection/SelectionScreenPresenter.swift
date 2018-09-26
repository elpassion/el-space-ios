import UIKit

protocol SelectionScreenPresenting {
    func presentHub()
}

class SelectionScreenPresenter: SelectionScreenPresenting {

    init(activitiesCoordinatorFactory: ActivitiesCoordinatorCreation,
         viewControllerPresenter: ViewControllerPresenting,
         presenterViewController: UIViewController) {
        self.activitiesCoordinatorFactory = activitiesCoordinatorFactory
        self.viewControllerPresenter = viewControllerPresenter
        self.presenterViewController = presenterViewController
    }

    func presentHub() {
        let coordinator = activitiesCoordinatorFactory.activitiesCoordinator()
        self.coordinator = coordinator
        let navigationController = presenterViewController.navigationController
        viewControllerPresenter.push(viewController: coordinator.initialViewController, on: presenterViewController)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: Private

    private let activitiesCoordinatorFactory: ActivitiesCoordinatorCreation
    private let viewControllerPresenter: ViewControllerPresenting
    private let presenterViewController: UIViewController
    private var coordinator: Coordinator?

}
