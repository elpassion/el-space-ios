@testable import ELSpace

class ActivityCoordinatorFactoryMock: ActivityCoordinatorCreation {

    var fakeCoordinator: Coordinator = CoordinatorFake()

    private(set) var didCallActivityCoordinator: Bool = false
    private(set) var activityCoordinatorCount = 0

    // MARK: - ActivityCoordinatorCreation

    func activityCoordinator() -> Coordinator {
        activityCoordinatorCount += 1
        didCallActivityCoordinator = true
        return fakeCoordinator
    }

}
