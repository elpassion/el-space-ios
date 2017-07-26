import RxSwift
import Alamofire
import RxAlamofire

protocol RequestWrapper {
    func request(_ url: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?) -> Observable<(HTTPURLResponse, Data)>
}

extension SessionManager: RequestWrapper {

    func request(_ url: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?) -> Observable<(HTTPURLResponse, Data)> {
        return request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).rx.responseData()
    }

}
