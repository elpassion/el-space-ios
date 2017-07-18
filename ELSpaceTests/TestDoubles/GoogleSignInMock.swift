//
//  Created by Bartlomiej Guminiak on 12/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

@testable
import ELSpace

class GoogleSignInMock: GoogleSignInProtocol {

    weak var delegate: GIDSignInDelegate!

    weak var uiDelegate: GIDSignInUIDelegate!

    var signInCalled = false

    func signIn() {
        signInCalled = true
    }

    var hostedDomain: String!

}
