@testable import ELSpace

import RxSwift

class ActivitiesControllerSpy: ActivitiesControlling {

    private(set) var didCallFetchData = false
    private(set) var dateCaptured: Date?

    let isLoadingSubject = PublishSubject<Bool>()
    let reportsSubject = PublishSubject<[ReportDTO]>()
    let projectsSubject = PublishSubject<[ProjectDTO]>()
    let holidaysSubject = PublishSubject<[Int]>()
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

    var holidays: Observable<[Int]> {
        return holidaysSubject.asObservable()
    }

    func fetchData(for date: Date) {
        didCallFetchData = true
        dateCaptured = date
    }

}
