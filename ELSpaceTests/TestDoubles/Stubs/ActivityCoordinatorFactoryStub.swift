import Foundation

@testable import ELSpace

class ActivityCoordinatorCreationStub: ActivityCoordinatorCreation {

    var coordinatorStub: Coordinator = CoordinatorFake()

    // MARK: ActivityCoordinatorCreation

    func activityCoordinator(date: Date, report: ReportDTO?, projectScope: [ProjectDTO]) -> Coordinator {
        return coordinatorStub
    }

}
