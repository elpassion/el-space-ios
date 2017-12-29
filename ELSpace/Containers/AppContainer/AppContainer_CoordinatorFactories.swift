extension AppContainer: SelectionCoordinatorCreation,
                        ActivitiesCoordinatorCreation,
                        ActivityCoordinatorCreation {

    // MARK: - SelectionCoordinatorCreation

    func selectionCoordinator(googleIdToken: String) -> Coordinator {
        let viewController = selectionViewController(googleIdToken: googleIdToken)
        let selectionScreenPresenter = self.selectionScreenPresenter(presenterViewController: viewController)
        return SelectionCoordinator(viewController: viewController,
                                    selectionViewController: viewController,
                                    selectionScreenPresenter: selectionScreenPresenter,
                                    hubSession: hubSession)
    }

    // MARK: - ActivityCoordinatorCreation

    func activitiesCoordinator() -> Coordinator {
        return ActivitiesCoordinator(activitiesViewController: activitiesViewController(),
                                     activitiesViewModel: activitiesViewModel(),
                                     presenter: ViewControllerPresenter(),
                                     activityCoordinatorFactory: self)
    }

    // MARK: - ActivityCoordinatorCreation

    func activityCoordinator() -> Coordinator {
        return ActivityCoordinator(viewController: activityViewController(),
                                   viewModel: activityViewModel())
    }

}

protocol SelectionCoordinatorCreation {
    func selectionCoordinator(googleIdToken: String) -> Coordinator
}

protocol ActivitiesCoordinatorCreation {
    func activitiesCoordinator() -> Coordinator
}

protocol ActivityCoordinatorCreation {
    func activityCoordinator() -> Coordinator
}
