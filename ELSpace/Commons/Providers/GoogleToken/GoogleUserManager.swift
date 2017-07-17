//
//  Created by Bartlomiej Guminiak on 14/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import RxSwift

protocol GoogleUserManaging {

    func signIn(on viewController: UIViewController) -> Observable<GIDGoogleUser>

}

class GoogleUserManager: GoogleUserManaging {

    private let googleUserProvider: GoogleUserProviding

    private let emailValidator: EmailValidating

    private let hostedDomain = "elpassion.pl"

    init(googleUserProvider: GoogleUserProviding = GoogleUserProvider(),
         emailValidator: EmailValidating = EmailValidator()) {
        self.googleUserProvider = googleUserProvider
        self.emailValidator = emailValidator

        self.googleUserProvider.configure(with: hostedDomain)
    }

    func signIn(on viewController: UIViewController) -> Observable<GIDGoogleUser> {
        return googleUserProvider.signIn(on: viewController).validate(with: emailValidator, expectedDomain: hostedDomain)
    }

}
