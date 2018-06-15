import RxSwift
import Alamofire

protocol ActivityServiceProtocol {
    func addActivity(_ activity: NewActivityDTO) -> Observable<Void>
    func updateActivity(_ activity: NewActivityDTO, forId id: Int) -> Observable<Void>
    func deleteActivity(_ activity: ReportDTO) -> Observable<Void>
}

class ActivityService: ActivityServiceProtocol {

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    // MARK: ActivitiesServiceProtocol

    func addActivity(_ activity: NewActivityDTO) -> Observable<Void> {
        var params = [String: Any]()
        params["performed_at"] = activity.performedAt
        params["report_type"] = activity.reportType
        if let projectId = activity.projectId {
            params["project_id"] = projectId
        }
        if let value = activity.value {
            params["value"] = value
        }
        if let comment = activity.comment {
            params["comment"] = comment
        }
        return apiClient.request(path: "activities",
                                 method: .post,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: nil)
            .map {
                if let error = ApiError(response: $0) { throw error }
                return Void()
            }
    }

    func updateActivity(_ activity: NewActivityDTO, forId id: Int) -> Observable<Void> {
        guard let projectId = activity.projectId,
              let hours = activity.value,
              let comment = activity.comment else { return Observable.error("Missing data for update") }
        let params: [String: Any] = [
            "project_id": projectId,
            "value": hours,
            "comment": comment
        ]
        return apiClient.request(path: "activities/\(id)",
                                 method: .put,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: nil)
            .map {
                if let error = ApiError(response: $0) { throw error }
                return Void()
        }
    }

    func deleteActivity(_ activity: ReportDTO) -> Observable<Void> {
        return apiClient.request(path: "activities/\(activity.id)",
                                 method: .delete,
                                 parameters: nil,
                                 encoding: JSONEncoding.default,
                                 headers: nil)
            .map {
                if let error = ApiError(response: $0) { throw error }
                return Void()
            }
    }

    // MARK: Private

    private let apiClient: ApiClientProtocol

}
