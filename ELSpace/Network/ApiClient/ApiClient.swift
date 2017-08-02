import RxSwift
import Alamofire

protocol ApiClientProtocol {
    func request(path: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> Observable<Response>
}

class ApiClient: ApiClientProtocol {

    init(requestPerformer: Requesting) {
        self.requestPerformer = requestPerformer
    }

    // MARK: - ApiClientProtocol

    func request(path: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> Observable<Response> {
        return requestPerformer.request(urlComponents(withPath: path), method: method, parameters: parameters, headers: headers)
    }

    // MARK: - Private

    private let requestPerformer: Requesting

    private func urlComponents(withPath: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "hub.elpassion.com"
        urlComponents.path = "/api/v1/\(withPath)"
        return urlComponents
    }

}
