import UIKit

struct ActivityViewControllerCreator: ActivityViewControllerCreating {

    func activityViewController() -> UIViewController & ActivityViewControlling {
        return ActivityViewController(assembly: Assembly())
    }

    private struct Assembly: ActivityViewControllerAssembly {

        var typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling {
            return ChooserActivityTypeAssembly().viewController()
        }

        var formViewController: UIViewController & ActivityFormViewControlling {
            return ActivityFormAssembly().viewController()
        }

        var notificationCenter: NotificationCenter {
            return NotificationCenter.default
        }

    }
}

protocol ActivityViewControllerCreating {
    func activityViewController() -> UIViewController & ActivityViewControlling
}
