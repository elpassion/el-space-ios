@testable import ELSpace

import UIKit
import RxSwift
import GoogleSignIn

class GoogleUserManagerSpy: GoogleUserManaging {

    var resultError: Error?
    var resultUser: GIDGoogleUser?
    private(set) var viewController: UIViewController?
    private(set) var didCallAutoSignIn = false

    // MARK: - GoogleUserManaging

    var error: Observable<Error> {
        return errorSubject.asObservable()
    }

    var validationSuccess: Observable<GIDGoogleUser> {
        return validationSuccessSubject.asObservable()
    }

    func signIn(on viewController: UIViewController) {
        self.viewController = viewController
        if let error = resultError {
            errorSubject.onNext(error)
        } else if let user = resultUser {
            validationSuccessSubject.onNext(user)
        }
    }

    var autoSignIn: AnyObserver<Void> {
        return AnyObserver(onNext: { [weak self] in self?.didCallAutoSignIn = true })
    }

    // MARK: - Private

    private let errorSubject = PublishSubject<Error>()
    private let validationSuccessSubject = PublishSubject<GIDGoogleUser>()

}
