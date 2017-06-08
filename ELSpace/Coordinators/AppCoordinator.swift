//
//  Created by Michał Czerniakowski on 07.06.2017.
//Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator {
    
    fileprivate let window: UIWindow
    
    fileprivate let loginViewController: LoginViewController
    
    fileprivate let selectionViewController: SelectionViewController
    
    fileprivate let googleUserProvider: GoogleUserProviding
    
    
    init(window: UIWindow, screenFactory: ScreenFactoring = ScreenFactory(), googleUserProvider: GoogleUserProviding = GoogleUserProvider()) {
        self.window = window
        self.loginViewController = screenFactory.loginViewController()
        self.selectionViewController = screenFactory.selectionViewController()
        
        self.googleUserProvider = googleUserProvider
        self.googleUserProvider.configure()
        
        self.loginViewController.delegate = self
    }
    
    func present() {
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
    
    fileprivate let disposeBag = DisposeBag()
    
}

extension AppCoordinator: LoginViewControllerDelegate {
    
    func loginAction(in viewController: LoginViewController) {
        googleUserProvider.signIn(on: viewController)
        googleUserProvider.userCompletion = { [weak self] user in
        .subscribe(onNext: { user in
            guard let selectionView = self?.selectionViewController else { return }
            viewController.present(selectionView, animated: true, completion: nil)
        }, onError: { error in
            print(error)
        }).addDisposableTo(disposeBag)
    }
}
