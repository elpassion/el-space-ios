@testable import ELSpace

import RxSwift
import GoogleSignIn

class GoogleUserValidatorSpy: GoogleUserValidation {

    var resultError: Error? {
        didSet {
            errorSubject.onNext(resultError)
        }
    }

    var validateResult: Bool?

    // MARK: - GoogleUserValidation

    var error: Observable<Error> {
        return errorSubject.asObservable().unwrap()
    }

    func validate(user: GIDGoogleUser, hostedDomain: String) -> Bool {
        return validateResult ?? true
    }

    // MARK: - Private

    private let errorSubject = PublishSubject<Error?>()

}
