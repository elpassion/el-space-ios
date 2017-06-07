//
//  Created by Michał Czerniakowski on 31.05.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import HexColors

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
    }

    private func configureSubviews() {
        view.backgroundColor = UIColor("1BCEDF")
        loginView.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    func didTapLoginButton() {
    }
}
