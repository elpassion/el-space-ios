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
        window.rootViewController = configuredLoginViewController()
        window.makeKeyAndVisible()
    }

    fileprivate let disposeBag = DisposeBag()

}

extension AppCoordinator {

    func configuredLoginViewController() -> LoginViewController {
        let loginViewController = screenFactory.loginViewController()

        loginViewController.loginButtonTap
        .flatMapFirst { [unowned self] _ in
                return self.googleUserManager.signIn(on: loginViewController)
        }.subscribe(onNext: { [weak self] _ in
                guard let selectionViewController = self?.screenFactory.selectionViewController() else { return }
                loginViewController.present(selectionViewController, animated: true, completion: nil)
        }, onError: { [weak self] error in
                guard let alertController = self?.screenFactory.messageAlertController(message: error.localizedDescription) else { return }
                loginViewController.present(alertController, animated: true, completion: nil)
        }).disposed(by: disposeBag)

        return loginViewController
    }

}
