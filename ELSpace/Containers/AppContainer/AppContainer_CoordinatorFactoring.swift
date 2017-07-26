protocol CoordinatorFactoring {
    func selectionCoordinator(googleIdToken: String) -> Coordinator
}

extension AppContainer: CoordinatorFactoring {

    func selectionCoordinator(googleIdToken: String) -> Coordinator {
        return SelectionCoordinator(assembly: selectionCoordinatorAssembly, googleIdToken: googleIdToken)
    }

}
