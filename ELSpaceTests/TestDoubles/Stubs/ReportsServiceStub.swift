@testable import ELSpace

import RxSwift

class ReportsServiceStub: ReportsServiceProtocol {

    var result: [ReportDTO]?

    func getReports(startDate: String, endDate: String) -> Observable<[ReportDTO]> {
        return result == nil ? Observable.empty() : Observable.just(result!)
    }

}
