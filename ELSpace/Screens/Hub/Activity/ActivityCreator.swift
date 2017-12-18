import UIKit

struct ActivityCreator: ActivityCreating {

    func activityViewController() -> UIViewController {
        return ActivityViewController(assembly: Assembly())
    }

    private struct Assembly: ActivityViewControllerAssembly {

        var chooserActivityTypeViewController: UIViewController & ChooserActivityTypesViewControlling {
            return ChooserActivityTypeAssembly().viewController()
        }

    }
}

protocol ActivityCreating {
    func activityViewController() -> UIViewController
}
