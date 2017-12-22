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
        return ActivitiesCoordinator(activityCreator: ActivityCreator(),
                                     activitiesViewController: self.activitiesViewController(),
                                     activitiesViewModel: activitiesViewModel(),
                                     presenter: ViewControllerPresenter())
    }

    // MARK: - ActivityCoordinatorCreation

    func activityCoordinator() -> Coordinator {
        return ActivityCoordinator(viewController: activityViewController())
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
