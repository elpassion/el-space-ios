@testable import ELSpace

import Alamofire
import RxSwift

class ApiClientSpy: ApiClientProtocol {

    var response: Response?
    private(set) var path: String?
    private(set) var method: HTTPMethod?
    private(set) var parameters: Parameters?
    private(set) var encoding: ParameterEncoding?
    private(set) var headers: HTTPHeaders?

    // MARK: - ApiClientProtocol

    func request(path: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding?, headers: HTTPHeaders?) -> Observable<Response> {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
        return response == nil ? Observable.empty() : Observable.just(response!)
    }

}
