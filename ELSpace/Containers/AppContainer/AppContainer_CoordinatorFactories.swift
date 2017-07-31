extension AppContainer: SelectionCoordinatorCreation {

    func selectionCoordinator(googleIdToken: String) -> Coordinator {
        let viewController = selectionViewController(googleIdToken: googleIdToken)
        return SelectionCoordinator(debateRunner: debateRunner,
                                    viewController: viewController,
                                    selectionViewController: viewController)
    }

}

protocol SelectionCoordinatorCreation {
    func selectionCoordinator(googleIdToken: String) -> Coordinator
}
