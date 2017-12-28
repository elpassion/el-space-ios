import Foundation

extension AppContainer: ActivitiesViewModelCreation,
                        ActivityViewModelCreation {

    // MARK: ActivitiesViewModelCreation

    func activitiesViewModel() -> ActivitiesViewModelProtocol {
        return ActivitiesViewModel(activitiesController: activitiesController, todayDate: Date())
    }

    // MARK: ActivityViewModelCreation

    func activityViewModel() -> ActivityViewModelProtocol {
        return ActivityViewModel(service: activityService)
    }

}

protocol ActivitiesViewModelCreation {
    func activitiesViewModel() -> ActivitiesViewModelProtocol
}

protocol ActivityViewModelCreation {
    func activityViewModel() -> ActivityViewModelProtocol
}
