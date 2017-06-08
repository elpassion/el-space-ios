//
//  Created by Bartlomiej Guminiak on 07/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import GoogleSignIn

protocol GoogleUserProviding: class {
    
    func configure()
    func signIn(on viewController: GIDSignInUIDelegate)
    var userCompletion: ((GIDGoogleUser) -> ())? { get set }
    
}

class GoogleUserProvider: NSObject, GoogleUserProviding, GIDSignInDelegate {
    
    private let googleSignIn: GoogleSignInProtocol
    
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
    
    func signIn(on viewController: GIDSignInUIDelegate) {
        googleSignIn.uiDelegate = viewController
        googleSignIn.signIn()
    }
    
    var userCompletion: ((GIDGoogleUser) -> ())?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            userCompletion?(user)
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
}
