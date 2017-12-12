extension AppContainer: SelectionCoordinatorCreation,
                        ActivitiesCoordinatorCreation {

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
        let activityViewController = self.activityViewController()
        let activitiesViewController = self.activitiesViewController()
        return ActivitiesCoordinator(activityViewController: activityViewController,
                                     activitiesViewController: activitiesViewController,
                                     activitiesViewModel: activitiesViewModel,
                                     presenter: ViewControllerPresenter())
    }

}

protocol SelectionCoordinatorCreation {
    func selectionCoordinator(googleIdToken: String) -> Coordinator
}

protocol ActivitiesCoordinatorCreation {
    func activitiesCoordinator() -> Coordinator
}
