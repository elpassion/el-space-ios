import RxSwift

protocol HubTokenServiceProtocol {

    func getHubToken(googleTokenId: String) -> Observable<String>

}

class HubTokenService: HubTokenServiceProtocol {

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    // MARK: - HubTokenServiceProtocol

    func getHubToken(googleTokenId: String) -> Observable<String> {
        let param = ["id_token": googleTokenId]
        return apiClient.request(path: "api_keys", method: .post, parameters: param)
            .map {
                if let error = ApiError(response: $0) { throw error }
                return $0.data.hubToken
            }
    }

    // MARK: - Private

    private let apiClient: ApiClientProtocol

}

class ApiError: Error {

    let statusCode: Int

    init?(response: Response) {
        switch response.statusCode {
            case 200...299: return nil
            default: self.statusCode = response.statusCode
        }
    }

}