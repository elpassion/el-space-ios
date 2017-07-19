//
//  Created by Bartlomiej Guminiak on 07/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import GoogleSignIn

protocol GoogleSignInProtocol: class {

    weak var delegate: GIDSignInDelegate! { get set }
    weak var uiDelegate: GIDSignInUIDelegate! { get set }
    func signIn()
    func disconnect()
    var hostedDomain: String! { get set }

}

extension GIDSignIn: GoogleSignInProtocol {}

extension UIViewController: GIDSignInUIDelegate {}
