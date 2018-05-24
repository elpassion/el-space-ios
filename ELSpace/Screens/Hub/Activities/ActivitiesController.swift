import RxSwift

protocol ActivitiesControlling {
    var reports: Observable<[ReportDTO]> { get }
    var projects: Observable<[ProjectDTO]> { get }
    var isLoading: Observable<Bool> { get }
    var didFinishFetch: Observable<Void> { get }
    func fetchData(from: String, to: String)
}

class ActivitiesController: ActivitiesControlling {

    init(reportsService: ReportsServiceProtocol,
         projectsService: ProjectsServiceProtocol,
         holidaysService: HolidaysServiceProtocol) {
        self.reportsService = reportsService
        self.projectsService = projectsService
        self.holidaysService = holidaysService
    }

    // MARK: - ActivitiesControlling

    var reports: Observable<[ReportDTO]> {
        return reportsSubject.asObservable()
    }

    var projects: Observable<[ProjectDTO]> {
        return projectsSubject.asObservable()
    }

    var isLoading: Observable<Bool> {
        return activityIndicator.asSharedSequence().asObservable()
    }

    var didFinishFetch: Observable<Void> {
        return didFinishFetchSubject.asObservable()
    }

    func fetchData(from: String, to: String) {
        Observable.combineLatest(reportsService.getReports(startDate: from, endDate: to), projectsService.getProjects()) { (reports: $0, projects: $1) }
            .trackActivity(activityIndicator)
            .subscribe(onNext: { [weak self] (reports, projects) in
                self?.reportsSubject.onNext(reports)
                self?.projectsSubject.onNext(projects)
            }, onDisposed: { [weak self] in
                self?.didFinishFetchSubject.onNext(())
            }).disposed(by: disposeBag)
    }

    // MARK: - Private

    private let reportsService: ReportsServiceProtocol
    private let projectsService: ProjectsServiceProtocol
    private let holidaysService: HolidaysServiceProtocol

    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()
    private let reportsSubject = PublishSubject<[ReportDTO]>()
    private let projectsSubject = PublishSubject<[ProjectDTO]>()

    private let didFinishReportFetch = Variable<Bool>(false)
    private let didFinishProjectFetch = Variable<Bool>(false)
    private let didFinishFetchSubject = PublishSubject<Void>()

}
