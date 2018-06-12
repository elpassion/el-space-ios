import Foundation

extension AppContainer: ActivitiesViewModelCreation,
                        ActivityViewModelCreation {

    // MARK: ActivitiesViewModelCreation

    func activitiesViewModel() -> ActivitiesViewModelProtocol {
        let dateFormatters = ActivitiesDateFormatters(monthFormatter: DateFormatter.monthFormatter,
                                                      shortDateFormatter: DateFormatter.shortDateFormatter)
        return ActivitiesViewModel(activitiesController: activitiesController,
                                   todayDate: Date(),
                                   dateFormatters: dateFormatters)
    }

    // MARK: ActivityViewModelCreation

    func activityViewModel(report: ReportDTO, projectScope: [ProjectDTO]) -> ActivityViewModelProtocol {
        return ActivityViewModel(service: activityService)
    }

}

protocol ActivitiesViewModelCreation {
    func activitiesViewModel() -> ActivitiesViewModelProtocol
}

protocol ActivityViewModelCreation {
    func activityViewModel(report: ReportDTO, projectScope: [ProjectDTO]) -> ActivityViewModelProtocol
}
