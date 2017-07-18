//
//  Created by Michał Czerniakowski on 07.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import RxSwift
import ELDebate

class AppCoordinator {

    init(window: UIWindow,
         screenFactory: ScreenFactoring = ScreenFactory(),
         googleUserManager: GoogleUserManaging = GoogleUserManager(),
         debateRunner: DebateRunning = DebateRunner()) {
        self.window = window
        self.loginViewController = screenFactory.loginViewController()
        self.navigationController = screenFactory.navigationController(withRoot: loginViewController)
        self.selectionViewController = screenFactory.selectionViewController()
        self.screenFactory = screenFactory
        self.debateRunner = debateRunner
        self.googleUserManager = googleUserManager
        setupBindings()
    }

    func present() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    // MARK: Private

    private let window: UIWindow
    fileprivate let navigationController: UINavigationController
    fileprivate let loginViewController: LoginViewController
    fileprivate let selectionViewController: SelectionViewController
    fileprivate let googleUserManager: GoogleUserManaging
    fileprivate let debateRunner: DebateRunning
    fileprivate let screenFactory: ScreenFactoring

    // MARK: Bindings

    private func setupBindings() {
        setupLoginViewControllerBindings()
        setupSelectionViewControllerBindings()
    }

    fileprivate let disposeBag = DisposeBag()

}

extension AppCoordinator {

    fileprivate func setupLoginViewControllerBindings() {
        loginViewController.loginButtonTap
            .flatMapFirst { [weak self] _ -> Observable<GIDGoogleUser> in
                guard let `self` = self else { return Observable.empty() }
                return self.googleUserManager.signIn(on: self.loginViewController)
            }.subscribe(onNext: { [weak self] _ in
                self?.presentSelectionController()
            }, onError: { [weak self] error in
                self?.presentError(message: error.localizedDescription)
            }).disposed(by: disposeBag)
    }

    private func presentSelectionController() {
        loginViewController.navigationController?.pushViewController(selectionViewController, animated: true)
    }

    private func presentError(message: String) {
        let alert = screenFactory.messageAlertController(message: message)
        loginViewController.present(alert, animated: true)
    }

}

extension AppCoordinator {

    fileprivate func setupSelectionViewControllerBindings() {
        selectionViewController.debateButtonTapObservable
            .subscribe(onNext: { [weak self] in
                self?.runDebate()
            }).disposed(by: disposeBag)
    }

    private func runDebate() {
        debateRunner.start(in: navigationController, applyingDebateStyle: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }

}
