//
//  Created by Bartlomiej Guminiak on 14/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import RxSwift

protocol GoogleUserManaging {

    var error: Observable<Error> { get }
    var validationSuccess: Observable<GIDGoogleUser> { get }
    func signIn(on viewController: UIViewController)

}

class GoogleUserManager: GoogleUserManaging {

    init(googleUserProvider: GoogleUserProviding = GoogleUserProvider(),
         googleUserValidator: GoogleUserValidation = GoogleUserValidator(),
         hostedDomain: String = "elpassion.pl") {
        self.googleUserProvider = googleUserProvider
        self.hostedDomain = hostedDomain
        self.googleUserValidator = googleUserValidator
        setupBindings()
    }

    var error: Observable<Error> {
        return errorSubject.asObservable()
    }

    var validationSuccess: Observable<GIDGoogleUser> {
        return validationSuccessSubject.asObservable()
    }

    func signIn(on viewController: UIViewController) {
        googleUserProvider.signIn(on: viewController)
    }

    // MARK: Private

    private let errorSubject = PublishSubject<Error>()
    private let validationSuccessSubject = PublishSubject<GIDGoogleUser>()
    private let googleUserProvider: GoogleUserProviding
    private let googleUserValidator: GoogleUserValidation
    private let hostedDomain: String

    private func disconnectIfNeeded(error: Error) {
        guard error is EmailValidator.EmailValidationError else { return }
        googleUserProvider.disconnect()
    }

    // MARK: Bindings

    private let disposeBag = DisposeBag()

    private func setupBindings() {
        googleUserProvider.user
            .subscribe(onNext: { [weak self] user in
                self?.validateEmail(user: user)
            }).disposed(by: disposeBag)

        Observable.of(
            googleUserProvider.error,
            googleUserValidator.error
        ).merge()
            .bind(to: errorSubject)
            .disposed(by: disposeBag)

        error
            .subscribe(onNext: { [weak self] error in
                self?.disconnectIfNeeded(error: error)
            }).disposed(by: disposeBag)
    }

    // MARK: Email validation

    private func validateEmail(user: GIDGoogleUser) {
        guard googleUserValidator.validate(user: user, hostedDomain: hostedDomain) else { return }
        validationSuccessSubject.onNext(user)
    }

}
