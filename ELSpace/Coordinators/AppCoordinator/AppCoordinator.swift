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

class AppCoordinator: Coordinator {

    init(assembly: AppCoordinatorAssembly) {
        self.assembly = assembly
        let loginViewController = assembly.loginViewController
        self.navigationController = UINavigationController(rootViewController: loginViewController)
        self.loginViewController = loginViewController
        self.googleUserManager = assembly.googleUserManager
        setupBindings()
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return navigationController
    }

    // MARK: - Private

    private let assembly: AppCoordinatorAssembly
    private let navigationController: UINavigationController
    private let loginViewController: LoginViewController
    private let googleUserManager: GoogleUserManaging
    private let isSigningIn = Variable<Bool>(false)

    // MARK: - Presenting

    private var presentedCoordinator: Coordinator?

    private func presentSelectionController() {
        let coordinator = assembly.selectionCoordinator
        self.presentedCoordinator = coordinator
        initialViewController.navigationController?.pushViewController(coordinator.initialViewController, animated: true)
    }

    private func presentError(error: EmailValidator.EmailValidationError) {
        let alert = assembly.messageAlertController(message: error.rawValue)
        loginViewController.present(alert, animated: true)
    }

    // MARK: - Error handling

    private func handleError(error: Error) {
        guard let error = error as? EmailValidator.EmailValidationError else { return }
        presentError(error: error)
    }

    // MARK: - Bindings

    private func setupBindings() {
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

    private let disposeBag = DisposeBag()

}
