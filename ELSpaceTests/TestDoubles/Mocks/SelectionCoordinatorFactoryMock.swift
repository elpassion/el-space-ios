@testable import ELSpace

class SelectionCoordinatorFactoryMock: SelectionCoordinatorCreation {

    var fakeCoordinator: Coordinator = CoordinatorFake()

    private(set) var didCallSelectionCoordinator: Bool = false
    private(set) var googleIdToken: String?

    func selectionCoordinator(googleIdToken: String) -> Coordinator {
        didCallSelectionCoordinator = true
        self.googleIdToken = googleIdToken
        return fakeCoordinator
    }

}
