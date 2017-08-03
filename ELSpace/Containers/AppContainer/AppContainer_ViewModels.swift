import Foundation

extension AppContainer {

    var activityViewModel: ActivityViewModelProtocol {
        return ActivityViewModel(activityController: activityController)
    }

}
