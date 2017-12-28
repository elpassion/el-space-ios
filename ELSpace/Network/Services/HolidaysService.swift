import RxSwift
import Mapper

protocol HolidaysServiceProtocol {
    func getHolidays() -> Observable<HolidaysDTO>
}

class HolidaysService: HolidaysServiceProtocol {

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    // MARK: - HolidaysServiceProtocol

    func getHolidays() -> Observable<HolidaysDTO> {
        return apiClient.request(path: "holidays", method: .get, parameters: nil, headers: nil)
            .map { reponse -> HolidaysDTO in
                if let error = ApiError(response: reponse) { throw error }
                let json = reponse.data.json
                return try HolidaysDTO(map: Mapper(JSON: json as NSDictionary))
        }
    }

    // MARK: - Private

    private let apiClient: ApiClientProtocol

}
