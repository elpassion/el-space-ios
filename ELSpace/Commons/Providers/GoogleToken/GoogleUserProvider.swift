//
//  Created by Bartlomiej Guminiak on 07/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import GoogleSignIn
import RxSwift
import RxCocoa

protocol GoogleUserProviding: class {

    func configure(with hostedDomain: String)
    func signIn(on viewController: UIViewController) -> Observable<GIDGoogleUser>

}

class GoogleUserProvider: NSObject, GoogleUserProviding, GIDSignInDelegate {

    private let googleSignIn: GoogleSignInProtocol
    private var userSubject: PublishSubject<GIDGoogleUser> = PublishSubject<GIDGoogleUser>()

    init(googleSignIn: GoogleSignInProtocol = GIDSignIn.sharedInstance()) {
        self.googleSignIn = googleSignIn
    }

    func configure(with hostedDomain: String) {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        if configureError != nil {
            userSubject.onError(NSError.googleConfiguration(description: String(describing: configureError)))
        }

        googleSignIn.delegate = self
        googleSignIn.hostedDomain = hostedDomain
    }

    func signIn(on viewController: UIViewController) -> Observable<GIDGoogleUser> {
        googleSignIn.uiDelegate = viewController
        googleSignIn.signIn()

        return userSubject.asObservable()
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            userSubject.onNext(user)
        } else {
            userSubject.onError(error)
        }
    }

}
