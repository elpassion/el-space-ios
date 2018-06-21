import UIKit

struct ActivityViewControllerCreator: ActivityViewControllerCreating {

    func activityViewController(activityType: ActivityType,
                                projectScope: [ProjectDTO],
                                alertFactory: AlertCreation,
                                viewControllerPresenter: ViewControllerPresenting) -> UIViewController & ActivityViewControlling {
        return ActivityViewController(activityType: activityType, assembly: Assembly(activityType: activityType,
                                                                                     projectScope: projectScope,
                                                                                     alertFactory: alertFactory,
                                                                                     viewControllerPresenter: viewControllerPresenter))
    }

    private struct Assembly: ActivityViewControllerAssembly {

        let activityType: ActivityType
        let projectScope: [ProjectDTO]
        let alertFactory: AlertCreation
        let viewControllerPresenter: ViewControllerPresenting

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
    func activityViewController(activityType: ActivityType,
                                projectScope: [ProjectDTO],
                                alertFactory: AlertCreation,
                                viewControllerPresenter: ViewControllerPresenting) -> UIViewController & ActivityViewControlling
}
