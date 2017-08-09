@testable import ELSpace

import RxSwift

class ActivityControllerSpy: ActivityControlling {

    private(set) var didCallGetProjects = false
    private(set) var didCallGetReports = false
    private(set) var getReportsFromCaptured: String?
    private(set) var getReportsToCaptured: String?

    let reportsSubject = PublishSubject<[ReportDTO]>()
    let projectsSubject = PublishSubject<[ProjectDTO]>()
    let didFinishFetchSubject = PublishSubject<Void>()

    // MARK: - ActivityControlling

    var reports: Observable<[ReportDTO]> {
        return reportsSubject.asObservable()
    }

    var projects: Observable<[ProjectDTO]> {
        return projectsSubject.asObservable()
    }

    var isLoading: Observable<Bool> {
        return Observable.empty()
    }

    var didFinishFetch: Observable<Void> {
        return didFinishFetchSubject.asObservable()
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
