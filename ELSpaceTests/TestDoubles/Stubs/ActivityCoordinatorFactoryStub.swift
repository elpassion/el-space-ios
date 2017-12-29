@testable import ELSpace

class ActivityCoordinatorCreationStub: ActivityCoordinatorCreation {

    var coordinatorStub: Coordinator = CoordinatorFake()

    // MARK: ActivityCoordinatorCreation

    func activityCoordinator() -> Coordinator {
        return coordinatorStub
    }

}
