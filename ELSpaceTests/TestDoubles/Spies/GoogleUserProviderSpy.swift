@testable import ELSpace

import RxSwift
import RxSwiftExt
import GoogleSignIn

class GoogleUserProviderSpy: GoogleUserProviding {

    private(set) var didDisconnect = false
    private(set) var didSignIn = false
    private(set) var didSignInOnViewController: UIViewController?

    var resultUser: GIDGoogleUser?

    var error: Observable<Error> {
        return Observable.empty()
    }

    var user: Observable<GIDGoogleUser> {
        return resultUserSubject.asObservable()
    }

    func signIn(on viewController: UIViewController) {
        didSignIn = true
        didSignInOnViewController = viewController
        resultUserSubject.onNext(resultUser!)
    }

    func disconnect() {
        didDisconnect = true
    }

    // MARK: Private

    private let resultUserSubject = PublishSubject<GIDGoogleUser>()

}
