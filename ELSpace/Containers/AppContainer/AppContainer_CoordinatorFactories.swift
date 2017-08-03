extension AppContainer: SelectionCoordinatorCreation,
                        ActivityCoordinatorCreation {

    // MARK: - SelectionCoordinatorCreation

    func selectionCoordinator(googleIdToken: String) -> Coordinator {
        let viewController = selectionViewController(googleIdToken: googleIdToken)
        return SelectionCoordinator(viewController: viewController,
                                    selectionViewController: viewController,
                                    debateRunner: debateRunner,
                                    activityCoordinatorFactory: self,
                                    viewControllerPresenter: viewControllerPresenter)
    }

    // MARK: - ActivityCoordinatorCreation

    func activityCoordinator() -> Coordinator {
        return ActivityCoordinator(viewController: activityViewController())
    }

}

protocol SelectionCoordinatorCreation {
    func selectionCoordinator(googleIdToken: String) -> Coordinator
}

protocol ActivityCoordinatorCreation {
    func activityCoordinator() -> Coordinator
}
