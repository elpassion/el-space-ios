//
//  Created by Michał Czerniakowski on 07.06.2017.
//Copyright © 2017 El Passion. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    fileprivate let window: UIWindow
    
    fileprivate let loginViewController = LoginViewController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func present() {
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
}
