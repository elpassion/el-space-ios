@testable import ELSpace

import RxSwift

class GoogleUserValidatorStub: GoogleUserValidation {

    var error: Observable<Error> {
        return Observable.empty()
    }

    func validate(user: GIDGoogleUser, hostedDomain: String) -> Bool {
        return true
    }

}
