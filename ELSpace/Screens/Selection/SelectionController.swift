import Foundation

protocol SelectionControllerSignIn {
    func signInToHub(with googleIdToken: String,
                     success: @escaping (_ hubToken: String) -> Void,
                     failure: @escaping (_ error: Error) -> Void)
}

class SelectionController: SelectionControllerSignIn {

    init(hubTokenService: HubTokenServiceProtocol, googleIdToken: String) {
        self.hubTokenService = hubTokenService
    }

    // MARK: - SelectionControllerLogin

    func signInToHub(with googleIdToken: String,
                     success: @escaping (_ hubToken: String) -> Void,
                     failure: @escaping (_ error: Error) -> Void) {
        _ = hubTokenService.getHubToken(googleTokenId: googleIdToken)
            .subscribe(onNext: { token in
                success(token)
            }, onError: { error in
                failure(error)
            })
    }

    // MARK: - Private

    private let hubTokenService: HubTokenServiceProtocol

}
