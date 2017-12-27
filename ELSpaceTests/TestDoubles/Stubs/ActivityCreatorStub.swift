@testable import ELSpace

import UIKit

class ActivityCreatorStub: ActivityViewControllerCreating {

    func activityViewController() -> UIViewController {
        return viewController
    }

    // MARK: - Stub

    var viewController = UIViewController(nibName: nil, bundle: nil)

}
