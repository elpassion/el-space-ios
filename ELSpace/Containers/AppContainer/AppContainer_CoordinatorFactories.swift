extension AppContainer: SelectionCoordinatorCreation,
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

    func activityCoordinator() -> Coordinator {
        let viewController = activityViewController()
        return ActivityCoordinator(viewController: viewController,
                                   activityViewController: viewController,
                                   viewModel: activityViewModel)
    }

}

protocol SelectionCoordinatorCreation {
    func selectionCoordinator(googleIdToken: String) -> Coordinator
}

protocol ActivityCoordinatorCreation {
    func activityCoordinator() -> Coordinator
}
