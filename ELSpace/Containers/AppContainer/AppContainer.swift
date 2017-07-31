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
        let loginViewController = self.loginViewController()
        let rootNavigationController = navigationController(rootViewController: loginViewController)
        appCoordinator = AppCoordinator(navigationController: rootNavigationController,
                                        loginViewController: loginViewController,
                                        selectionCoordinatorFactory: self,
                                        viewControllerPresenter: viewControllerPresenter)
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

    // MARK: - Controllers

    func selectionController(googleIdToken: String) -> SelectionControllerSignIn {
        return SelectionController(hubTokenService: hubTokenService,
                                   googleIdToken: googleIdToken)
    }

    // MARK: - Presenters

    var viewControllerPresenter: ViewControllerPresenting {
        return ViewControllerPresenter()
    }

    // MARK: - Mappers

    var googleUserMapper: GoogleUserMapping {
        return GoogleUserMapper()
    }

}
