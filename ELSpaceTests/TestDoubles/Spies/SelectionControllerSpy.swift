@testable import ELSpace

class SelectionControllerSpy: SelectionControllerSignIn {

    var error: Error?
    var token: String?

    // MARK: - SelectionControllerSignIn

    func signInToHub(success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        if let token = token {
            success(token)
        } else if let error = error {
            failure(error)
        }
    }

}
