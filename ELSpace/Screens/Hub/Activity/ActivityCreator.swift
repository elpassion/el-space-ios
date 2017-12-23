import UIKit

struct ActivityCreator: ActivityCreating {

    func activityViewController() -> UIViewController {
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

protocol ActivityCreating {
    func activityViewController() -> UIViewController
}
