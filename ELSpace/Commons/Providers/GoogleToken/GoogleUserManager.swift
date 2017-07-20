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
         hostedDomain: String = "elpassion.pl") {
        self.googleUserProvider = googleUserProvider
        self.hostedDomain = hostedDomain
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
    private let hostedDomain: String

    private func disconnectIfNeeded(error: Error) {
        guard error is EmailValidationError else { return }
        googleUserProvider.disconnect()
    }

    // MARK: Bindings

    private let disposeBag = DisposeBag()

    private func setupBindings() {
        googleUserProvider.user
            .subscribe(onNext: { [weak self] user in
                self?.validateEmail(user: user)
            }).disposed(by: disposeBag)

        googleUserProvider.error
            .bind(to: errorSubject)
            .disposed(by: disposeBag)

        error
            .subscribe(onNext: { [weak self] error in
                self?.disconnectIfNeeded(error: error)
            }).disposed(by: disposeBag)
    }

    // MARK: Email validation

    enum EmailValidationError: String, Error {
        case emailFormat = "Email format"
        case incorrectDomain = "Incorrect domain"
    }

    private func validateEmail(user: GIDGoogleUser) {
        guard let email = user.profile.email else { return }
        if isValidEmail(email: email) == false {
            errorSubject.onNext(EmailValidationError.emailFormat)
        } else if isValidDomain(email: email) == false {
            errorSubject.onNext(EmailValidationError.incorrectDomain)
        } else {
            validationSuccessSubject.onNext(user)
        }
    }

    private func isValidEmail(email: String) -> Bool {
        return email.isValidEmail()
    }

    private func isValidDomain(email: String) -> Bool {
        return email.emailDomain() == hostedDomain
    }

}
