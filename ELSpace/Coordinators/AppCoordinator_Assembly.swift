import UIKit
import ELDebate

protocol AppCoordinatorAssembly {
    var loginViewController: LoginViewController { get }
    var selectionViewController: SelectionViewController { get }
    var googleUserManager: GoogleUserManaging { get }
    var debateRunner: DebateRunning { get }
    func messageAlertController(message: String) -> UIAlertController
}

extension AppContainer {

    var appCoordinatorAssembly: AppCoordinatorAssembly {
        struct AnonymousAssembly: AppCoordinatorAssembly {
            let container: AppContainer

            var loginViewController: LoginViewController {
                return container.loginViewController
            }

            var selectionViewController: SelectionViewController {
                return container.selectionViewController
            }

            var googleUserManager: GoogleUserManaging {
                return container.googleUserManager
            }

            var debateRunner: DebateRunning {
                return container.debateRunner
            }

            func messageAlertController(message: String) -> UIAlertController {
                return container.messageAlertController(message: message)
            }
        }
        return AnonymousAssembly(container: self)
    }

}
