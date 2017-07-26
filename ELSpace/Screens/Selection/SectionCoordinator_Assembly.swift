import UIKit
import ELDebate

protocol SelectionCoordinatorAssembly {
    var selectionViewController: SelectionViewController { get }
    var debateRunner: DebateRunning { get }
    func selectionController(googleIdToken: String) -> SelectionControllerSignIn
    func messageAlertController(message: String) -> UIAlertController
}

extension AppContainer {

    var selectionCoordinatorAssembly: SelectionCoordinatorAssembly {
        struct AnonymousAssembly: SelectionCoordinatorAssembly {
            let container: AppContainer

            var selectionViewController: SelectionViewController {
                return container.selectionViewController
            }

            var debateRunner: DebateRunning {
                return container.debateRunner
            }

            func selectionController(googleIdToken: String) -> SelectionControllerSignIn {
                return container.selectionController(googleIdToken: googleIdToken)
            }

            func messageAlertController(message: String) -> UIAlertController {
                return container.messageAlertController(message: message)
            }
        }
        return AnonymousAssembly(container: self)
    }

}
