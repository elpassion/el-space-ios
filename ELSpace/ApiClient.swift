import RxSwift
import Alamofire

protocol ApiClientProtocol {
    func request(path: String, method: HTTPMethod, parameters: Parameters?) -> Observable<Response>
}

class ApiClient: ApiClientProtocol {

    init(requestPerformer: Requesting) {
        self.requestPerformer = requestPerformer
    }

    private let requestPerformer: Requesting

    func request(path: String, method: HTTPMethod, parameters: Parameters?) -> Observable<Response> {
        return requestPerformer.request(urlComponents(withPath: path), method: method, parameters: parameters)
    }

    func urlComponents(withPath: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "hub.elpassion.com"
        urlComponents.path = "/v1/api/\(withPath)"
        return urlComponents
    }

}
