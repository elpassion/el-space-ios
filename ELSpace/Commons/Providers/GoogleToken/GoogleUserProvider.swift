//
//  Created by Bartlomiej Guminiak on 07/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import GoogleSignIn
import RxSwift
import RxCocoa

protocol GoogleUserProviding {

    var user: Observable<GIDGoogleUser> { get }
    var error: Observable<Error> { get }
    func signIn(on viewController: UIViewController)
    func disconnect()

}

class GoogleUserProvider: NSObject, GoogleUserProviding, GIDSignInDelegate {

    init(googleSignIn: GoogleSignInProtocol = GIDSignIn.sharedInstance(),
         hostedDomain: String = "elpassion.pl") {
        self.googleSignIn = googleSignIn
        super.init()
        configure(with: hostedDomain)
    }

    var user: Observable<GIDGoogleUser> {
        return userSubject.asObservable()
    }

    var error: Observable<Error> {
        return errorSubject.asObservable()
    }

    func signIn(on viewController: UIViewController) {
        googleSignIn.uiDelegate = viewController
        googleSignIn.signIn()
    }

    func disconnect() {
        googleSignIn.disconnect()
    }

    // MARK: GIDSignInDelegate

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            userSubject.onNext(user)
        } else {
            errorSubject.onNext(error)
        }
    }

    // MARK: Private

    private let googleSignIn: GoogleSignInProtocol
    private let userSubject = PublishSubject<GIDGoogleUser>()
    private let errorSubject = PublishSubject<Error>()

    private func configure(with hostedDomain: String) {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        if configureError != nil {
            errorSubject.onNext(NSError.googleConfiguration(description: String(describing: configureError)))
        }
        googleSignIn.delegate = self
        googleSignIn.hostedDomain = hostedDomain
    }

}
