@testable import ELSpace

import GoogleSignIn

class GoogleUSerMapperFake: GoogleUserMapping {

    func getIdToken(user: GIDGoogleUser) -> String {
        return "fake_token"
    }

}
