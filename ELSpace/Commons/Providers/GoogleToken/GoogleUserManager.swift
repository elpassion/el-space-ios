//
//  Created by Bartlomiej Guminiak on 14/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import RxSwift

protocol GoogleUserManaging {

    func signIn(on viewController: UIViewController)
    var error: Observable<Error> { get }
    var signInSuccess: Observable<GIDGoogleUser> { get }

}

class GoogleUserManager: GoogleUserManaging {

    init(googleUserProvider: GoogleUserProviding = GoogleUserProvider(),
         emailValidator: EmailValidating = EmailValidator()) {
        self.googleUserProvider = googleUserProvider
        self.emailValidator = emailValidator
        self.googleUserProvider.configure(with: hostedDomain)
    }

    var error: Observable<Error> {
        return errorSubject.asObservable()
    }

    var signInSuccess: Observable<GIDGoogleUser> {
        return signInSuccessSubject.asObservable()
    }

    func signIn(on viewController: UIViewController) {
        googleUserProvider
            .signIn(on: viewController)
            .validate(with: emailValidator, expectedDomain: hostedDomain)
            .subscribe(onNext: { user in
                self.signInSuccessSubject.onNext(user)
            }, onError: { [weak self] error in
                self?.errorSubject.onNext(error)
                self?.googleUserProvider.disconnect()
            }).disposed(by: disposeBag)
    }

    // MARK: Private

    private let errorSubject = PublishSubject<Error>()
    private let signInSuccessSubject = PublishSubject<GIDGoogleUser>()
    private let googleUserProvider: GoogleUserProviding
    private let emailValidator: EmailValidating
    private let hostedDomain = "elpassion.pl"
    private let disposeBag = DisposeBag()

}
