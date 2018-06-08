//
//  Created by Bartlomiej Guminiak on 12/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

@testable
import ELSpace

import GoogleSignIn

class GoogleSignInMock: GoogleSignInProtocol {

    var signInCalled = false
    var disconnectCalled = false
    var didCallSignInSilently = false
    var didCallAuthInKeychain = false
    var authInKeychainResult = false

    // MARK: - GoogleSignInProtocol

    weak var delegate: GIDSignInDelegate!
    weak var uiDelegate: GIDSignInUIDelegate!

    func signIn() {
        signInCalled = true
    }

    func disconnect() {
        disconnectCalled = true
    }

    func signInSilently() {
        didCallSignInSilently = true
    }

    func hasAuthInKeychain() -> Bool {
        didCallAuthInKeychain = true
        return authInKeychainResult
    }

    var hostedDomain: String!

}
