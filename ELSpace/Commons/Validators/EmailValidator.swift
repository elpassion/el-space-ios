import RxSwift

protocol EmailValidation {

    var error: Observable<Error> { get }
    func validateEmail(email: String, hostedDomain: String) -> Bool

}

class EmailValidator: EmailValidation {

    enum EmailValidationError: String, Error {
        case emailFormat = "Incorrect email format"
        case incorrectDomain = "Incorrect domain"
    }

    // MARK: EmailValidation

    var error: Observable<Error> {
        return errorSubject.asObservable()
    }

    func validateEmail(email: String, hostedDomain: String) -> Bool {
        if isValidEmail(email: email) == false {
            errorSubject.onNext(EmailValidator.EmailValidationError.emailFormat)
        } else if isValidDomain(email: email, hostedDomain: hostedDomain) == false {
            errorSubject.onNext(EmailValidator.EmailValidationError.incorrectDomain)
        } else {
            return true
        }
        return false
    }

    // MARK: Private

    private func isValidEmail(email: String) -> Bool {
        return email.isValidEmail()
    }

    private func isValidDomain(email: String, hostedDomain: String) -> Bool {
        return email.emailDomain() == hostedDomain
    }

    private let errorSubject = PublishSubject<Error>()

}
