import ELDebate

protocol SelectionScreenPresenting {
    func presentDebate()
    func presentHub()
}

class SelectionScreenPresenter: SelectionScreenPresenting {

    init(debateRunner: DebateRunning,
         activitiesCoordinatorFactory: ActivitiesCoordinatorCreation,
         viewControllerPresenter: ViewControllerPresenting,
         presenterViewController: UIViewController) {
        self.debateRunner = debateRunner
        self.activitiesCoordinatorFactory = activitiesCoordinatorFactory
        self.viewControllerPresenter = viewControllerPresenter
        self.presenterViewController = presenterViewController
    }

    func presentDebate() {
        guard let navigationController = presenterViewController.navigationController else { return }
        debateRunner.start(in: navigationController, applyingDebateStyle: true)
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.navigationBar.setBackgroundImage(nil, for: .default)
    }

    func presentHub() {
        let coordinator = activitiesCoordinatorFactory.activitiesCoordinator()
        self.coordinator = coordinator
        let navigationController = presenterViewController.navigationController
        viewControllerPresenter.push(viewController: coordinator.initialViewController, on: presenterViewController)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: Private

    private let debateRunner: DebateRunning
    private let activitiesCoordinatorFactory: ActivitiesCoordinatorCreation
    private let viewControllerPresenter: ViewControllerPresenting
    private let presenterViewController: UIViewController
    private var coordinator: Coordinator?

}
