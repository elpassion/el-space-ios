//
//  Created by Michał Czerniakowski on 07.06.2017.
//Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator {
    
    fileprivate let window: UIWindow
    
    fileprivate let screenFactory: ScreenFactoring
    
    fileprivate let googleUserManager: GoogleUserManaging
    
    
    init(window: UIWindow, screenFactory: ScreenFactoring = ScreenFactory(), googleUserManager: GoogleUserManaging = GoogleUserManager()) {
        self.window = window
        self.screenFactory = screenFactory
        self.googleUserManager = googleUserManager
    }
    
    func present() {
        let loginViewController = screenFactory.loginViewController()
        loginViewController.delegate = self
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
    
    fileprivate let disposeBag = DisposeBag()
    
}

extension AppCoordinator: LoginViewControllerDelegate {
    
    func loginAction(in viewController: LoginViewController) {
        googleUserManager.signIn(on: viewController)
        .subscribe(onNext: { [weak self] user in
            print("logged in as \(user.profile.email)")
            guard let selectionViewController = self?.screenFactory.selectionViewController() else { return }
            viewController.present(selectionViewController, animated: true, completion: nil)
        }, onError: { [weak self] error in
            guard let alertController = self?.screenFactory.messageAlertController(message: error.localizedDescription) else { return }
            viewController.present(alertController, animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
    }
}
