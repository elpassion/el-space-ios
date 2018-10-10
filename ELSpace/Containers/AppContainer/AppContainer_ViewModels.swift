import Foundation

extension AppContainer: ActivitiesViewModelCreation,
                        ActivityViewModelCreation,
                        ProjectSearchViewModelCreation {

    // MARK: ActivitiesViewModelCreation

    func activitiesViewModel() -> ActivitiesViewModelProtocol {
        let dateFormatters = ActivitiesDateFormatters(monthFormatter: DateFormatter.monthFormatter,
                                                      shortDateFormatter: DateFormatter.shortDateFormatter)
        return ActivitiesViewModel(activitiesController: activitiesController,
                                   todayDate: Date(),
                                   dateFormatters: dateFormatters)
    }

    // MARK: ActivityViewModelCreation

    func activityViewModel(activityType: ActivityType, projectScope: [ProjectDTO]) -> ActivityViewModelProtocol {
        return ActivityViewModel(activityType: activityType, service: activityService)
    }

    // MARK: ProjectSearchViewModelCreation

    func projectSearchViewModel(projectId: Int?) -> ProjectSearchViewModelProtocol {
        return ProjectSearchViewModel(projectId: projectId)
    }

}

protocol ActivitiesViewModelCreation {
    func activitiesViewModel() -> ActivitiesViewModelProtocol
}

protocol ActivityViewModelCreation {
    func activityViewModel(activityType: ActivityType, projectScope: [ProjectDTO]) -> ActivityViewModelProtocol
}

protocol ProjectSearchViewModelCreation {
    func projectSearchViewModel(projectId: Int?) -> ProjectSearchViewModelProtocol
}
