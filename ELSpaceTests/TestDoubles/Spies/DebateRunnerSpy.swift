@testable import ELSpace

import ELDebate

class DebateRunnerSpy: DebateRunning {

    private(set) var navigationController: UINavigationController?
    private(set) var applyingDebateStyle: Bool?

    // MARK: DebateRunning

    func start(in navigationController: UINavigationController, applyingDebateStyle: Bool) {
        self.navigationController = navigationController
        self.applyingDebateStyle = applyingDebateStyle
    }

}
