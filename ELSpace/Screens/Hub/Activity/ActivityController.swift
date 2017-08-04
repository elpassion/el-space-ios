import RxSwift

protocol ActivityControlling {
    var reports: Observable<[ReportDTO]> { get }
    var projects: Observable<[ProjectDTO]> { get }
    var isLoading: Observable<Bool> { get }
    func getReports(from: String, to: String)
    func getProjects()
}

class ActivityController: ActivityControlling {

    init(reportsService: ReportsServiceProtocol,
         projectsService: ProjectsServiceProtocol) {
        self.reportsService = reportsService
        self.projectsService = projectsService
        setupBindings()
    }

    // MARK: - ActivityControlling

    var reports: Observable<[ReportDTO]> {
        return reportsSubject.asObservable()
    }

    var projects: Observable<[ProjectDTO]> {
        return projectsSubject.asObservable()
    }

    var isLoading: Observable<Bool> {
        return isLoadingVar.asObservable()
    }

    func getReports(from: String, to: String) {
        isLoadingReports.value = true
        _ = reportsService.getReports(startDate: from, endDate: to)
            .subscribe(onNext: { [weak self] reports in
                self?.reportsSubject.onNext(reports)
            }, onDisposed: { [weak self] in
                self?.isLoadingReports.value = false
            })
    }

    func getProjects() {
        isLoadingProjects.value = true
        _ = projectsService.getProjects()
            .subscribe(onNext: { [weak self] projects in
                self?.projectsSubject.onNext(projects)
            }, onDisposed: { [weak self] in
                self?.isLoadingProjects.value = false
            })
    }

    // MARK: - Private

    private let reportsService: ReportsServiceProtocol
    private let projectsService: ProjectsServiceProtocol
    private let reportsSubject = PublishSubject<[ReportDTO]>()
    private let projectsSubject = PublishSubject<[ProjectDTO]>()

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
    }

    private let disposeBag = DisposeBag()

}
