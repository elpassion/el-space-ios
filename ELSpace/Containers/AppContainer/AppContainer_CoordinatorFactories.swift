extension AppContainer: SelectionCoordinatorCreation,
                        ActivityCoordinatorCreation {

    // MARK: - SelectionCoordinatorCreation

    func selectionCoordinator(googleIdToken: String) -> Coordinator {
        let viewController = selectionViewController(googleIdToken: googleIdToken)
        return SelectionCoordinator(debateRunner: debateRunner,
                                    viewController: viewController,
                                    selectionViewController: viewController,
                                    activityCoordinatorFactory: self)
    }

    // MARK: - ActivityCoordinatorCreation

    func activityCoordinator() -> ActivityCoordinator {
        return ActivityCoordinator(viewController: activityViewController())
    }

}

protocol SelectionCoordinatorCreation {
    func selectionCoordinator(googleIdToken: String) -> Coordinator
}

protocol ActivityCoordinatorCreation {
    func activityCoordinator() -> ActivityCoordinator
}
