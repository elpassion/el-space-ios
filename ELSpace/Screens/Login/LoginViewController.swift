//
//  Created by Michał Czerniakowski on 31.05.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import HexColors
import Anchorage

protocol LoginViewControllerDelegate: class {
    
    func loginAction(in viewController: LoginViewController)
    
}

class LoginViewController: UIViewController {

    weak var delegate: LoginViewControllerDelegate?
    
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
        loginView.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    func didTapLoginButton() {
        delegate?.loginAction(in: self)
    }
    
}
