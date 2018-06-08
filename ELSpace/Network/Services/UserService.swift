import RxSwift
import Alamofire
import Mapper

protocol UserServiceProtocol {
    func getUser() -> Observable<UserDTO>
}

class UserService: UserServiceProtocol {

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getUser() -> Observable<UserDTO> {
        return apiClient.request(path: "users/me",
                                 method: .get,
                                 parameters: nil,
                                 encoding: JSONEncoding.default,
                                 headers: nil)
            .map {
                if let error = ApiError(response: $0) { throw error }
                let json = $0.data.json
                return try UserDTO(map: Mapper(JSON: json as NSDictionary))
            }
    }
    
    // MARK: - Privates
    
    private let apiClient: ApiClientProtocol

}
