import Alamofire
import RxSwift

protocol Requesting {
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?) -> Observable<Response>
}

class RequestPerformer: Requesting {

    init(sessionManager: RequestWrapper) {
        self.sessionManager = sessionManager
    }

    private let sessionManager: RequestWrapper

    func request(_ url: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?) -> Observable<Response> {
        return sessionManager.request(url,
                                      method: method,
                                      parameters: parameters,
                                      encoding: URLEncoding.queryString,
                                      headers: nil)
            .map { (response, data) -> Response in
                return Response(statusCode: response.statusCode, data: data)
            }
    }

}
