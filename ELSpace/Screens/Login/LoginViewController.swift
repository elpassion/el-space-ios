//
//  Created by Michał Czerniakowski on 31.05.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import HexColors
import Anchorage
import RxSwift

class LoginViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func loadView() {
        view = LoginView()
    }

    private var loginView: LoginView {
        guard let loginView = view as? LoginView else { fatalError("Expected LoginView but got \(type(of: view))") }
        return loginView
    }

    var loginButtonTap: Observable<Void> {
        return loginView.loginButton.rx.tap.asObservable()
    }

}
