import UIKit
import Alamofire
import RxSwift

class ApiClientHubDecorator: ApiClientProtocol {

    init(apiClient: ApiClientProtocol, hubSession: HubSession) {
        self.apiClient = apiClient
        self.hubSession = hubSession
    }

    func request(path: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> Observable<Response> {
        var header: [String: String]? = headers ?? [:]
        if let token = hubSession.accessToken {
            header?.add(dict: ["X-Access-Token": token])
        }
        return apiClient.request(path: path, method: method, parameters: parameters, headers: header)
    }

    // MARK: - Private

    private let hubSession: HubSession
    private let apiClient: ApiClientProtocol

}
