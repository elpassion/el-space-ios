import UIKit

struct ActivityViewControllerCreator: ActivityViewControllerCreating {

    func activityViewController(activityType: ActivityType, projectScope: [ProjectDTO]) -> UIViewController & ActivityViewControlling {
        return ActivityViewController(activityType: activityType, assembly: Assembly(activityType: activityType, projectScope: projectScope))
    }

    private struct Assembly: ActivityViewControllerAssembly {

        let activityType: ActivityType
        let projectScope: [ProjectDTO]

        var typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling {
            return ChooserActivityTypeAssembly().viewController(activityType: activityType)
        }

        var formViewController: UIViewController & ActivityFormViewControlling {
            return ActivityFormAssembly().viewController(activityType: activityType, projectScope: projectScope)
        }

        var notificationCenter: NotificationCenter {
            return NotificationCenter.default
        }

    }
}

protocol ActivityViewControllerCreating {
    func activityViewController(activityType: ActivityType, projectScope: [ProjectDTO]) -> UIViewController & ActivityViewControlling
}
