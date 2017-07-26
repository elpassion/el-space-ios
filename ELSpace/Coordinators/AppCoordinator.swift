//
//  Created by Michał Czerniakowski on 07.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import ELDebate
import Alamofire

protocol Coordinator {
    var initialViewController: UIViewController { get }
}

class AppCoordinator: Coordinator {

    init(appCoordinatorAssembly: AppCoordinatorAssembly) {
        self.appCoordinatorAssembly = appCoordinatorAssembly
        let loginViewController = appCoordinatorAssembly.loginViewController
        self.navigationController = UINavigationController(rootViewController: loginViewController)
        self.loginViewController = loginViewController
        self.selectionViewController = appCoordinatorAssembly.selectionViewController
        self.googleUserManager = appCoordinatorAssembly.googleUserManager
        self.debateRunner = appCoordinatorAssembly.debateRunner
        setupBindings()
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return navigationController
    }

    // MARK: - Private
    fileprivate let appCoordinatorAssembly: AppCoordinatorAssembly
    fileprivate let navigationController: UINavigationController
    fileprivate let loginViewController: LoginViewController
    fileprivate let selectionViewController: SelectionViewController
    fileprivate let googleUserManager: GoogleUserManaging
    fileprivate let debateRunner: DebateRunning
    fileprivate let isSigningIn = Variable<Bool>(false)

    // MARK: - Bindings

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
                self?.isSigningIn.value = false
                self?.handleError(error: error)
            }).disposed(by: disposeBag)

        googleUserManager.validationSuccess
            .subscribe(onNext: { [weak self] user in
                self?.isSigningIn.value = false
                self?.presentSelectionController()
            }).disposed(by: disposeBag)
    }

    private func presentSelectionController() {
        loginViewController.navigationController?.pushViewController(selectionViewController, animated: true)
    }

    private func presentError(error: EmailValidator.EmailValidationError) {
        let alert = appCoordinatorAssembly.messageAlertController(message: error.rawValue)
        loginViewController.present(alert, animated: true)
    }

    private func handleError(error: Error) {
        guard let error = error as? EmailValidator.EmailValidationError else { return }
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
