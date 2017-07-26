import UIKit
import Alamofire
import ELDebate

protocol AppPresenting {
    func presentApp()
}

class AppContainer: AppPresenting {

    var debateRunner: DebateRunning {
        return DebateRunner()
    }

    // MARK: - AppPresenting

    func presentApp() {
        appCoordinator = AppCoordinator(assembly: appCoordinatorAssembly)
        window = UIWindow(frame: mainScreen.bounds)
        window?.rootViewController = appCoordinator?.initialViewController
        window?.makeKeyAndVisible()
    }

    // MARK: - Private

    private var window: UIWindow?
    private var appCoordinator: Coordinator?

    private var mainScreen: UIScreen {
        return UIScreen.main
    }

}
