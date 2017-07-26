protocol CoordinatorFactoring {
    var selectionCoordinator: Coordinator { get }
}

extension AppContainer: CoordinatorFactoring {

    var selectionCoordinator: Coordinator {
        return SelectionCoordinator(assembly: selectionCoordinatorAssembly)
    }

}
