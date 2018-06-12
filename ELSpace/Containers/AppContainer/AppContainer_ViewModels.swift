import Foundation

extension AppContainer: ActivitiesViewModelCreation,
                        ActivityViewModelCreation {

    // MARK: ActivitiesViewModelCreation

    func activitiesViewModel() -> ActivitiesViewModelProtocol {
        return ActivitiesViewModel(activitiesController: activitiesController, todayDate: Date())
    }

    // MARK: ActivityViewModelCreation

    func activityViewModel(report: ReportDTO, projectScope: [ProjectDTO]) -> ActivityViewModelProtocol {
        return ActivityViewModel(report: report, service: activityService)
    }

}

protocol ActivitiesViewModelCreation {
    func activitiesViewModel() -> ActivitiesViewModelProtocol
}

protocol ActivityViewModelCreation {
    func activityViewModel(report: ReportDTO, projectScope: [ProjectDTO]) -> ActivityViewModelProtocol
}
