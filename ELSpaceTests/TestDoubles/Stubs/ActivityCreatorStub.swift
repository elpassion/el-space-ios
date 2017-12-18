@testable import ELSpace

import UIKit

class ActivityCreatorStub: ActivityCreating {

    func activityViewController() -> UIViewController {
        return viewController
    }

    // MARK: - Stub

    var viewController = UIViewController(nibName: nil, bundle: nil)

}
