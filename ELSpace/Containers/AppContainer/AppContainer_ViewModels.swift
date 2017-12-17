import Foundation

extension AppContainer: ActivitiesViewModelCreation {

    func activitiesViewModel() -> ActivitiesViewModelProtocol {
        return ActivitiesViewModel(activitiesController: activitiesController)
    }

}

protocol ActivitiesViewModelCreation {
    func activitiesViewModel() -> ActivitiesViewModelProtocol
}
