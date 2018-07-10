import RxSwift
import Mapper

protocol ProjectsServiceProtocol {
    func getProjects() -> Observable<[ProjectDTO]>
}

class ProjectsService: ProjectsServiceProtocol {

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func getProjects() -> Observable<[ProjectDTO]> {
        return apiClient.request(path: "projects", method: .get, parameters: ["sort":"recent"], encoding: nil, headers: nil)
            .map {
            if let error = ApiError(response: $0) { throw error }
            let jsonArray = $0.data.jsonArray
            return try jsonArray.map { try ProjectDTO(map: Mapper(JSON: $0 as NSDictionary)) }
        }
    }

    // MARK: Private

    private let apiClient: ApiClientProtocol

}
