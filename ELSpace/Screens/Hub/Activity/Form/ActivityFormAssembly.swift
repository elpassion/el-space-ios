import UIKit

struct ActivityFormAssembly {

    func viewController(activityType: ActivityType, projectScope: [ProjectDTO]) -> UIViewController & ActivityFormViewControlling {
        let viewModel = ActivityFormViewModel(activityType: activityType, projectScope: projectScope)
        return ActivityFormViewController(viewModel: viewModel)
    }

}
