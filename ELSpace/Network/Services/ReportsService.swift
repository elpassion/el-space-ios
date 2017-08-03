import RxSwift
import Mapper
import Alamofire

protocol ReportsServiceProtocol {
    func getReports(startDate: String, endDate: String) -> Observable<[ReportDTO]>
}

class ReportsService: ReportsServiceProtocol {

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    // MARK: - ReportsServiceProtocol

    func getReports(startDate: String, endDate: String) -> Observable<[ReportDTO]> {
        let params: [String: String] = [
            "start_date": startDate,
            "end_date": endDate
        ]
        return apiClient.request(path: "activities", method: .get, parameters: params, headers: nil)
            .map {
                if let error = ApiError(response: $0) { throw error }
                let jsonArray = $0.data.jsonArray
                return try jsonArray.map { try ReportDTO(map: Mapper(JSON: $0 as NSDictionary)) }
            }
    }

    // MARK: - ApiClientProtocol

    private let apiClient: ApiClientProtocol

}
