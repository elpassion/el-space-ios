import RxSwift

protocol ActivitiesControlling {
    var reports: Observable<[ReportDTO]> { get }
    var projects: Observable<[ProjectDTO]> { get }
    var isLoading: Observable<Bool> { get }
    var didFinishFetch: Observable<Void> { get }
    func getReports(from: String, to: String)
    func getProjects()
}

class ActivitiesController: ActivitiesControlling {

    init(reportsService: ReportsServiceProtocol,
         projectsService: ProjectsServiceProtocol,
         holidaysService: HolidaysServiceProtocol) {
        self.reportsService = reportsService
        self.projectsService = projectsService
        self.holidaysService = holidaysService
        setupBindings()
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

    func getReports(from: String, to: String) {
        didFinishReportFetch.value = false
        reportsService.getReports(startDate: from, endDate: to)
            .trackActivity(activityIndicator)
            .subscribe(onNext: { [weak self] reports in
                self?.reportsSubject.onNext(reports)
            }, onDisposed: { [weak self] in
                self?.didFinishReportFetch.value = true
            }).disposed(by: disposeBag)
    }

    func getProjects() {
        didFinishProjectFetch.value = false
        projectsService.getProjects()
            .trackActivity(activityIndicator)
            .subscribe(onNext: { [weak self] projects in
                self?.projectsSubject.onNext(projects)
            }, onDisposed: { [weak self] in
                self?.didFinishProjectFetch.value = true
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


    // MARK: - Bindings

    private func setupBindings() {
        Observable.of(
            didFinishReportFetch.asObservable(),
            didFinishProjectFetch.asObservable()
        ).merge()
            .map { [weak self] _ in
                return self?.didFinishProjectFetch.value == true && self?.didFinishReportFetch.value == true
            }.ignore(false)
            .map { _ in () }
            .bind(to: didFinishFetchSubject)
            .disposed(by: disposeBag)
    }

}
