@testable import ELSpace

import RxSwift

class ActivityControllerSpy: ActivityControlling {

    private(set) var didCallGetProjects = false
    private(set) var didCallGetReports = false
    private(set) var getReportsFromCaptured: String?
    private(set) var getReportsToCaptured: String?

    var reports: Observable<[ReportDTO]> {
        return Observable.empty()
    }
    var projects: Observable<[ProjectDTO]> {
        return Observable.empty()
    }

    var isLoading: Observable<Bool> {
        return Observable.empty()
    }

    var didFinishFetch: Observable<Void> {
        return Observable.empty()
    }

    func getProjects() {
        didCallGetProjects = true
    }

    func getReports(from: String, to: String) {
        didCallGetReports = true
        getReportsFromCaptured = from
        getReportsToCaptured = to
    }

}
