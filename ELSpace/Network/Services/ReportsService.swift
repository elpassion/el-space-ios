import RxSwift
import Mapper
import Alamofire

protocol ReportsServiceProtocol {
    func getReports(startDate: String?, endDate: String?) -> Observable<[ReportDTO]>
}

class ReportsService: ReportsServiceProtocol {

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func getReports(startDate: String?, endDate: String?) -> Observable<[ReportDTO]> {
        let params: [String: String] = [
            "start_date": startDate ?? "",
            "end_date": endDate ?? ""
        ]
        return apiClient.request(path: "activities", method: .get, parameters: params, headers: nil)
            .map { response -> [ReportDTO] in
                let jsonArray = response.data.array
                return try jsonArray.map { try ReportDTO(map: Mapper(JSON: $0 as NSDictionary)) }
            }
    }

    // MARK: - ApiClientProtocol

    private let apiClient: ApiClientProtocol

}
