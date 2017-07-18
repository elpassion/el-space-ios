//
//  Created by Michał Czerniakowski on 07.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import RxSwift
import ELDebate

class AppCoordinator {
    
    fileprivate let window: UIWindow
    fileprivate let navigationController: UINavigationController
    fileprivate let loginViewController: LoginViewController
    fileprivate let selectionViewController: SelectionViewController
    fileprivate let googleUserProvider: GoogleUserProviding
    fileprivate let debateRunner: DebateRunning
    
    init(window: UIWindow,
         screenFactory: ScreenFactoring = ScreenFactory(),
         googleUserProvider: GoogleUserProviding = GoogleUserProvider(),
         debateRunner: DebateRunning = DebateRunner()) {
        self.window = window
        self.loginViewController = screenFactory.loginViewController()
        self.navigationController = screenFactory.navigationController(withRoot: loginViewController)
        self.selectionViewController = screenFactory.selectionViewController()
        self.debateRunner = debateRunner
        self.googleUserProvider = googleUserProvider
        self.googleUserProvider.configure(with: "elpassion.pl")
        setupLoginObservable()
    }
    
    func present() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    fileprivate let disposeBag = DisposeBag()

    private func setupLoginObservable() {
        loginViewController.loginButtonTap
            .flatMapFirst { [weak self] _ -> Observable<GIDGoogleUser> in
                guard let `self` = self else { return Observable.empty() }
                return self.googleUserProvider.signIn(on: self.loginViewController)
            }.subscribe(onNext: { [weak self] user in
                print("logged in as \(user.profile.email)")
                guard let selectionView = self?.selectionViewController else { return }
                selectionView.delegate = self
                self?.loginViewController.navigationController?.pushViewController(selectionView, animated: true)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
}

extension AppCoordinator: SelectionViewControllerDelegate {
    
    func debateAction(vc: SelectionViewController) {
        debateRunner.start(in: navigationController, applyingDebateStyle: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
    
}
