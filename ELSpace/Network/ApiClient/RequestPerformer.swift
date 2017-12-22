import Alamofire
import RxSwift

protocol Requesting {
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding?, headers: HTTPHeaders?) -> Observable<Response>
}

class RequestPerformer: Requesting {

    init(sessionManager: RequestWrapper) {
        self.sessionManager = sessionManager
    }

    // MARK: - Requesting

    func request(_ url: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding?,
                 headers: HTTPHeaders?) -> Observable<Response> {
        return sessionManager.request(url,
                                      method: method,
                                      parameters: parameters,
                                      encoding: {
                                          guard let encoding = encoding else {
                                              return URLEncoding.queryString
                                          }
                                          return encoding
                                      }(),
                                      headers: headers)
            .map { (response, data) -> Response in
                return Response(statusCode: response.statusCode, data: data)
            }
    }

    // MARK: - Private

    private let sessionManager: RequestWrapper

}
