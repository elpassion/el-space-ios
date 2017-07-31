@testable import ELSpace

class SelectionCoordinatorFactoryMock: SelectionCoordinatorCreation {

    var fakeCoordinator: Coordinator = CoordinatorFake()

    private(set) var didCallSelectionCoordinator: Bool = false
    private(set) var selectionCoordinatorCount = 0
    private(set) var googleIdToken: String?

    // MARK: - SelectionCoordinatorCreation

    func selectionCoordinator(googleIdToken: String) -> Coordinator {
        didCallSelectionCoordinator = true
        self.googleIdToken = googleIdToken
        self.selectionCoordinatorCount += 1
        return fakeCoordinator
    }

}
