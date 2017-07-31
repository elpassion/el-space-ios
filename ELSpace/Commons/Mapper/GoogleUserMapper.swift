import UIKit
import GoogleSignIn

protocol GoogleUserMapping {
    func getIdToken(user: GIDGoogleUser) -> String
}

class GoogleUserMapper: GoogleUserMapping {

    func getIdToken(user: GIDGoogleUser) -> String {
        return user.authentication.idToken
    }

}
