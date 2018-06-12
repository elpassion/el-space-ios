import RxSwift
import Alamofire

protocol ActivityServiceProtocol {
    func addActivity(_ activity: NewActivityDTO) -> Observable<Void>
    func deleteActivity(_ activity: ReportDTO) -> Observable<Void>
}

class ActivityService: ActivityServiceProtocol {

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    // MARK: ActivitiesServiceProtocol

    func addActivity(_ activity: NewActivityDTO) -> Observable<Void> {
        let params: [String: Any] = [
            "project_id": activity.projectId,
            "user_id": activity.userId,
            "value": activity.value,
            "performed_at": activity.performedAt,
            "comment": activity.comment,
            "report_type": activity.reportType
        ]
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
