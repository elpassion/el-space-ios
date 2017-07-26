import UIKit
import ELDebate

protocol AppCoordinatorAssembly {
    var loginViewController: LoginViewController { get }
    var googleUserManager: GoogleUserManaging { get }
    var selectionCoordinator: Coordinator { get }
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

            var selectionCoordinator: Coordinator {
                return container.selectionCoordinator
            }

            func messageAlertController(message: String) -> UIAlertController {
                return container.messageAlertController(message: message)
            }
        }
        return AnonymousAssembly(container: self)
    }

}
