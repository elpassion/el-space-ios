import Foundation

extension AppContainer {

    var activitiesViewModel: ActivitiesViewModelProtocol {
        return ActivitiesViewModel(activitiesController: activitiesController)
    }

}
