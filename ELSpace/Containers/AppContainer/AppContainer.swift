import UIKit

protocol AppPresenting {
    func presentApp()
}

class AppContainer: AppPresenting {

    var hubSession: HubSession = HubSession()
    let raportDateProvider = RaportDateProvider(monthFormatter: DateFormatter.monthFormatter)

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

}
