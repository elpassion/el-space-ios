@testable import ELSpace

import RxSwift
import Alamofire

class RequestWrapperSpy: RequestWrapper {

    var response: (HTTPURLResponse, Data)?
    private(set) var url: URLConvertible?
    private(set) var method: HTTPMethod?
    private(set) var parameters: Parameters?
    private(set) var encoding: ParameterEncoding?
    private(set) var headers: HTTPHeaders?

    // MARK: - RequestWrapper

    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<(HTTPURLResponse, Data)> {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
        return response == nil ? Observable.empty() : Observable.just(response!)
    }

}
