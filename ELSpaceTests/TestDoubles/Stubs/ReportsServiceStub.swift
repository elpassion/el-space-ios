@testable import ELSpace

import RxSwift

class ReportsServiceStub: ReportsServiceProtocol {

    var result: [ReportDTO]?

    // MARK: - ReportsServiceProtocol

    func getReports(startDate: String, endDate: String) -> Observable<[ReportDTO]> {
        return result == nil ? Observable.empty() : Observable.just(result!)
    }

}
