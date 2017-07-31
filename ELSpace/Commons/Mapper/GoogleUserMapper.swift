import UIKit
import GoogleSignIn

protocol GoogleUserMapping {
    func getIdToken(user: GIDGoogleUser) -> String
}

class GoogleUserMapper: GoogleUserMapping {

    // MARK: - GoogleUserMapping

    func getIdToken(user: GIDGoogleUser) -> String {
        return user.authentication.idToken
    }

}
