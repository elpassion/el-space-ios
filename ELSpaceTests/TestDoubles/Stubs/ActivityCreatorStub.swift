@testable import ELSpace

import UIKit

class ActivityCreatorStub: ActivityViewControllerCreating {

    func activityViewController() -> UIViewController & ActivityViewControlling {
        return viewController
    }

    // MARK: - Stub

    var viewController = ActivityViewControllerStub()

}
