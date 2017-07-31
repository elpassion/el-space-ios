@testable import ELSpace

import UIKit

class AlertFactoryFake: AlertCreation {

    func messageAlertController(with title: String?, message: String?) -> UIAlertController {
        return UIAlertController(title: "fake_title", message: "fake_message", preferredStyle: .alert)
    }

}
