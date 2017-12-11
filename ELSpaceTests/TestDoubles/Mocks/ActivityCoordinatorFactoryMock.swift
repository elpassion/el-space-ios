@testable import ELSpace

class ActivitiesCoordinatorFactoryMock: ActivitiesCoordinatorCreation {

    var fakeCoordinator: Coordinator = CoordinatorFake()

    private(set) var didCallActivityCoordinator: Bool = false
    private(set) var activityCoordinatorCount = 0

    // MARK: - ActivityCoordinatorCreation

    func activitiesCoordinator() -> Coordinator {
        activityCoordinatorCount += 1
        didCallActivityCoordinator = true
        return fakeCoordinator
    }

}
