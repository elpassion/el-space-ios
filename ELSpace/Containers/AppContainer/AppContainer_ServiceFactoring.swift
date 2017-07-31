import Alamofire

extension AppContainer {

    var sessionManager: RequestWrapper {
        return SessionManager.default
    }

    var requestPerformer: Requesting {
        return RequestPerformer(sessionManager: sessionManager)
    }

    var apiClient: ApiClientProtocol {
        return ApiClient(requestPerformer: requestPerformer)
    }

    var hubTokenService: HubTokenServiceProtocol {
        return HubTokenService(apiClient: apiClient)
    }

    var googleUserManager: GoogleUserManaging {
        return GoogleUserManager()
    }

}
