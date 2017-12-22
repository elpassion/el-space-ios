import UIKit

struct ActivityCreator: ActivityCreating {

    func activityViewController() -> UIViewController {
        return ActivityViewController(chooserActivityTypeViewController: ChooserActivityTypeAssembly().viewController())
    }

}

protocol ActivityCreating {
    func activityViewController() -> UIViewController
}
