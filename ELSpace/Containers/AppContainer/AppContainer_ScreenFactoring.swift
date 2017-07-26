import UIKit

protocol ScreenFactoring {

    var loginViewController: LoginViewController { get }
    var selectionViewController: SelectionViewController { get }
    func messageAlertController(message: String) -> UIAlertController

}

extension AppContainer: ScreenFactoring {

    var loginViewController: LoginViewController {
        return LoginViewController()
    }

    var selectionViewController: SelectionViewController {
        return SelectionViewController()
    }

    func messageAlertController(message: String) -> UIAlertController {
        return UIAlertController.messageAlertViewController(with: message)
    }

}
