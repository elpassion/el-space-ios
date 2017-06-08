//
//  Created by Bartlomiej Guminiak on 07/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import GoogleSignIn
import RxSwift
import RxCocoa

protocol GoogleUserProviding: class {
    
    func configure()
    func signIn(on viewController: UIViewController) -> Observable<GIDGoogleUser>
    
}

class GoogleUserProvider: NSObject, GoogleUserProviding, GIDSignInDelegate {
    
    private let googleSignIn: GoogleSignInProtocol
    
    private var userSubject: PublishSubject<GIDGoogleUser> = PublishSubject<GIDGoogleUser>()
    
    init(googleSignIn: GoogleSignInProtocol = GIDSignIn.sharedInstance()) {
        self.googleSignIn = googleSignIn
    }
    
    func configure() {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
        googleSignIn.delegate = self
        googleSignIn.hostedDomain = "elpassion.pl"
    }

    func signIn(on viewController: UIViewController) -> Observable<GIDGoogleUser> {
        googleSignIn.uiDelegate = viewController
        googleSignIn.signIn()
        
        return userSubject.asObservable()
    }
    
    private var observable = Observable<GIDGoogleUser>.empty()
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            userSubject.onNext(user)
        } else {
            userSubject.onError(error)
        }
    }
    
}
