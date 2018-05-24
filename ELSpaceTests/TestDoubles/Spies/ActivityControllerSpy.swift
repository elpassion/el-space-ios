@testable import ELSpace

import RxSwift

class ActivitiesControllerSpy: ActivitiesControlling {

    private(set) var didCallFetchData = false
    private(set) var fromCaptured: String?
    private(set) var toCaptured: String?

    let isLoadingSubject = PublishSubject<Bool>()
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
        return isLoadingSubject.asObservable()
    }

    var didFinishFetch: Observable<Void> {
        return didFinishFetchSubject.asObservable()
    }

    func fetchData(from: String, to: String) {
        didCallFetchData = true
        fromCaptured = from
        toCaptured = to
    }

}
