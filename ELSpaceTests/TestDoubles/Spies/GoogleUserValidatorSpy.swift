@testable import ELSpace

import RxSwift

class GoogleUserValidatorSpy: GoogleUserValidation {

    var resultError: Error? {
        didSet {
            errorSubject.onNext(resultError)
        }
    }

    var validateResult: Bool?

    var error: Observable<Error> {
        return errorSubject.asObservable().unwrap()
    }

    func validate(user: GIDGoogleUser, hostedDomain: String) -> Bool {
        return validateResult ?? true
    }

    // MARK: Private

    private let errorSubject = PublishSubject<Error?>()

}