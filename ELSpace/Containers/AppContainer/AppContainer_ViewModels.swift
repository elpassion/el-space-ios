import Foundation

extension AppContainer: ActivitiesViewModelCreation {

    func activitiesViewModel() -> ActivitiesViewModelProtocol {
        return ActivitiesViewModel(activitiesController: activitiesController, todayDate: Date())
    }

}

protocol ActivitiesViewModelCreation {
    func activitiesViewModel() -> ActivitiesViewModelProtocol
}
