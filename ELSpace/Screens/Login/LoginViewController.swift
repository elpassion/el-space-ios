//
//  Created by Michał Czerniakowski on 31.05.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import HexColors
import Anchorage
import RxSwift

class LoginViewController: UIViewController {

    var loginButtonTap: Observable<Void> {
        return loginView.loginButton.rx.tap.asObservable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func loadView() {
        view = LoginView()
    }

    // MARK: - Private

    private var loginView: LoginView {
        guard let loginView = view as? LoginView else { fatalError("Expected LoginView but got \(type(of: view))") }
        return loginView
    }

}
