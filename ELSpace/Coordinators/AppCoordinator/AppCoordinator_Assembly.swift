import UIKit
import ELDebate

protocol AppCoordinatorAssembly {
    var loginViewController: LoginViewController { get }
    var googleUserManager: GoogleUserManaging { get }
    func selectionCoordinator(googleIdToken: String) -> Coordinator
    func messageAlertController(message: String) -> UIAlertController
}

extension AppContainer {

    var appCoordinatorAssembly: AppCoordinatorAssembly {
        struct AnonymousAssembly: AppCoordinatorAssembly {
            let container: AppContainer

            var loginViewController: LoginViewController {
                return container.loginViewController
            }

            var googleUserManager: GoogleUserManaging {
                return container.googleUserManager
            }

            func selectionCoordinator(googleIdToken: String) -> Coordinator {
                return container.selectionCoordinator(googleIdToken: googleIdToken)
            }

            func messageAlertController(message: String) -> UIAlertController {
                return container.messageAlertController(message: message)
            }
        }
        return AnonymousAssembly(container: self)
    }

}
