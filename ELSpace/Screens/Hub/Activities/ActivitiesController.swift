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
         projectsService: ProjectsServiceProtocol) {
        self.reportsService = reportsService
        self.projectsService = projectsService
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
        return isLoadingVar.asObservable()
    }

    var didFinishFetch: Observable<Void> {
        return didFinishFetchSubject.asObservable()
    }

    func getReports(from: String, to: String) {
        isLoadingReports.value = true
        didFinishReportFetch.value = false
        _ = reportsService.getReports(startDate: from, endDate: to)
            .subscribe(onNext: { [weak self] reports in
                self?.reportsSubject.onNext(reports)
            }, onDisposed: { [weak self] in
                self?.didFinishReportFetch.value = true
                self?.isLoadingReports.value = false
            })
    }

    func getProjects() {
        isLoadingProjects.value = true
        didFinishProjectFetch.value = false
        _ = projectsService.getProjects()
            .subscribe(onNext: { [weak self] projects in
                self?.projectsSubject.onNext(projects)
            }, onDisposed: { [weak self] in
                self?.isLoadingProjects.value = false
                self?.didFinishProjectFetch.value = true
            })
    }

    // MARK: - Private

    private let reportsService: ReportsServiceProtocol
    private let projectsService: ProjectsServiceProtocol

    private let reportsSubject = PublishSubject<[ReportDTO]>()
    private let projectsSubject = PublishSubject<[ProjectDTO]>()

    private let didFinishReportFetch = Variable<Bool>(false)
    private let didFinishProjectFetch = Variable<Bool>(false)
    private let didFinishFetchSubject = PublishSubject<Void>()

    // MARK: - Loading

    private let isLoadingReports = Variable<Bool>(false)
    private let isLoadingProjects = Variable<Bool>(false)
    private let isLoadingVar = Variable<Bool>(false)

    // MARK: - Bindings

    private func setupBindings() {
        Observable.of(
            isLoadingReports.asObservable(),
            isLoadingProjects.asObservable()
        ).merge()
            .bind(to: isLoadingVar)
            .disposed(by: disposeBag)

        Observable.of(
            didFinishReportFetch.asObservable(),
            didFinishProjectFetch.asObservable()
        ).merge()
            .map { [weak self] _ in
                return self?.didFinishProjectFetch.value == true && self?.didFinishReportFetch.value == true
            }.ignore(false)
            .map { _ in () }.debug()
            .bind(to: didFinishFetchSubject)
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
