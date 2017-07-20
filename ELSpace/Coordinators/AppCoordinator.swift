//
//  Created by Michał Czerniakowski on 07.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
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
    fileprivate let isSigningIn = Variable<Bool>(false)

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
            .ignoreWhen { [weak self] in self?.isSigningIn.value == true }
            .subscribe(onNext: { [weak self] in
                guard let viewController = self?.loginViewController else { return }
                self?.isSigningIn.value = true
                self?.googleUserManager.signIn(on: viewController)
            }).disposed(by: disposeBag)

        googleUserManager.error
            .subscribe(onNext: { [weak self] error in
                self?.handleError(error: error)
            }).disposed(by: disposeBag)

        googleUserManager.validationSuccess
            .subscribe(onNext: { [weak self] _ in
                self?.isSigningIn.value = false
                self?.presentSelectionController()
            }).disposed(by: disposeBag)
    }

    private func presentSelectionController() {
        loginViewController.navigationController?.pushViewController(selectionViewController, animated: true)
    }

    private func presentError(error: Error) {
        let alert = screenFactory.messageAlertController(message: error.localizedDescription)
        loginViewController.present(alert, animated: true)
    }

    private func handleError(error: Error) {
        isSigningIn.value = false
        guard let signInError = error as? GIDSignInErrorCode, signInError != .canceled else { return }
        presentError(error: error)
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
