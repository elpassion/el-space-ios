import Foundation

protocol SelectionControllerSignIn {
    func signInToHub(success: @escaping (_ hubToken: String) -> Void, failure: @escaping (_ error: Error) -> Void)
}

class SelectionController: SelectionControllerSignIn {

    init(hubTokenService: HubTokenServiceProtocol, googleIdToken: String) {
        self.hubTokenService = hubTokenService
        self.googleIdToken = googleIdToken
    }

    // MARK: - SelectionControllerLogin

    func signInToHub(success: @escaping (_ hubToken: String) -> Void, failure: @escaping (_ error: Error) -> Void) {
        _ = hubTokenService.getHubToken(googleTokenId: googleIdToken)
            .subscribe(onNext: { token in
                success(token)
            }, onError: { error in
                failure(error)
            })
    }

    // MARK: - Private

    private let googleIdToken: String
    private let hubTokenService: HubTokenServiceProtocol

}
