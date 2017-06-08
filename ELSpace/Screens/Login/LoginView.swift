//
//  Created by Michał Czerniakowski on 05.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import Anchorage
import HexColors

class LoginView: UIView {
    
    private let backgroundView = BackgroundGradientWithLogo()
    let loginButton = Button(frame: .zero)
    
    init() {
        super.init(frame: .zero)
        configureLoginButton()
        configureSubviews()
        configureAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configureLoginButton() {
        let buttonTitle = R.string.localizable.google_login_button()
        
        loginButton.setTitle(buttonTitle, for: .normal)
        loginButton.backgroundColor = UIColor("EF5350")
    }
    
    private func configureSubviews() {
        addSubview(backgroundView)
        addSubview(loginButton)
    }
    
    private func configureAutolayout() {
        backgroundView.edgeAnchors == self.edgeAnchors
        
        loginButton.heightAnchor == 50
        loginButton.bottomAnchor == self.bottomAnchor - 20
        loginButton.horizontalAnchors == self.horizontalAnchors + 20
    }
}
