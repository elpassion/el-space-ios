@testable import ELSpace

class ActivityCoordinatorCreationStub: ActivityCoordinatorCreation {

    var coordinatorStub: Coordinator = CoordinatorFake()

    // MARK: ActivityCoordinatorCreation

    func activityCoordinator(report: ReportDTO, projectScope: [ProjectDTO]) -> Coordinator {
        return coordinatorStub
    }

}
