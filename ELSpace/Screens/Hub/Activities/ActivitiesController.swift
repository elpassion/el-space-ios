import RxSwift
import RxCocoa

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
        isLoadingReports.accept(true)
        didFinishReportFetch.accept(false)
        _ = reportsService.getReports(startDate: from, endDate: to)
            .subscribe(onNext: { [weak self] reports in
                self?.reportsSubject.onNext(reports)
            }, onDisposed: { [weak self] in
                self?.didFinishReportFetch.accept(true)
                self?.isLoadingReports.accept(false)
            })
    }

    func getProjects() {
        isLoadingProjects.accept(true)
        didFinishProjectFetch.accept(false)
        _ = projectsService.getProjects()
            .subscribe(onNext: { [weak self] projects in
                self?.projectsSubject.onNext(projects)
            }, onDisposed: { [weak self] in
                self?.isLoadingProjects.accept(false)
                self?.didFinishProjectFetch.accept(true)
            })
    }

    // MARK: - Private

    private let reportsService: ReportsServiceProtocol
    private let projectsService: ProjectsServiceProtocol

    private let reportsSubject = PublishSubject<[ReportDTO]>()
    private let projectsSubject = PublishSubject<[ProjectDTO]>()

    private let didFinishReportFetch = BehaviorRelay(value: false)
    private let didFinishProjectFetch = BehaviorRelay(value: false)
    private let didFinishFetchSubject = PublishSubject<Void>()

    // MARK: - Loading

    private let isLoadingReports = BehaviorRelay(value: false)
    private let isLoadingProjects = BehaviorRelay(value: false)
    private let isLoadingVar = BehaviorRelay(value: false)

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
            .map { _ in () }
            .bind(to: didFinishFetchSubject)
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
