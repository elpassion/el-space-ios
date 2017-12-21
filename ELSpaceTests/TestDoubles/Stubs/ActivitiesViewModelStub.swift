import RxSwift

@testable import ELSpace

class ActivitiesControllingStub: ActivitiesControlling {

    let reportsSubject = PublishSubject<[ReportDTO]>()
    let projectsSubject = PublishSubject<[ProjectDTO]>()
    let isLoadingSubject = PublishSubject<Bool>()
    let didFinishFetchSubject = PublishSubject<Void>()

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

    func getReports(from: String, to: String) {}
    func getProjects() {}

}
