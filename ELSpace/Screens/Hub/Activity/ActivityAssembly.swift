import UIKit

struct ActivityAssembly {

    func viewController() -> UIViewController {
        return ActivityViewController(assembly: Assembly())
    }

    private struct Assembly: ActivityViewControllerAssembly {

        var chooserActivityTypeViewController: UIViewController & ChooserActivityTypesViewControlling {
            return ChooserActivityTypeAssembly().viewController()
        }

    }
}
