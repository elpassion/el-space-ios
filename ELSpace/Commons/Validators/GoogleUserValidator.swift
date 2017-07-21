import RxSwift
import GoogleSignIn

protocol GoogleUserValidation {

    var error: Observable<Error> { get }
    func validate(user: GIDGoogleUser, hostedDomain: String) -> Bool

}

class GoogleUserValidator: GoogleUserValidation {

    init(emailValidator: EmailValidation = EmailValidator()) {
        self.emailValidator = emailValidator
        setupBindings()
    }

    // MARK: GoogleUserValidation

    var error: Observable<Error> {
        return errorSubject.asObservable()
    }

    func validate(user: GIDGoogleUser, hostedDomain: String) -> Bool {
        return emailValidator.validateEmail(email: user.profile.email, hostedDomain: hostedDomain)
    }

    // MARK: Private

    private let emailValidator: EmailValidation
    private let errorSubject = PublishSubject<Error>()

    // MARK: Bindings

    private func setupBindings() {
        emailValidator.error
            .bind(to: errorSubject)
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
