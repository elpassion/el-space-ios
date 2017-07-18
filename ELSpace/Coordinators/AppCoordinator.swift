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
         googleUserProvider: GoogleUserProviding = GoogleUserProvider(),
         debateRunner: DebateRunning = DebateRunner()) {
        self.window = window
        self.loginViewController = screenFactory.loginViewController()
        self.navigationController = screenFactory.navigationController(withRoot: loginViewController)
        self.selectionViewController = screenFactory.selectionViewController()
        self.screenFactory = screenFactory
        self.debateRunner = debateRunner
        self.googleUserProvider = googleUserProvider
        self.googleUserProvider.configure(with: "elpassion.pl")
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
    fileprivate let googleUserProvider: GoogleUserProviding
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
                return self.googleUserProvider.signIn(on: self.loginViewController)
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
        loginViewController.navigationController?.pushViewController(alert, animated: true)
    }

}

extension AppCoordinator {

    fileprivate func setupSelectionViewControllerBindings() {
        selectionViewController.debateButtonTapObservable
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.debateRunner.start(in: self.navigationController, applyingDebateStyle: true)
                self.navigationController.setNavigationBarHidden(false, animated: true)
            }).disposed(by: disposeBag)
    }

}
