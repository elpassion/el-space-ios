import RxSwift
import RxCocoa

protocol ActivitiesControlling {
    var reports: Observable<[ReportDTO]> { get }
    var projects: Observable<[ProjectDTO]> { get }
    var holidays: Observable<[Int]> { get }
    var isLoading: Observable<Bool> { get }
    var didFinishFetch: Observable<Void> { get }
    func fetchData(for date: Date)
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

    var holidays: Observable<[Int]> {
        return holidaysRelay.asObservable()
    }

    var isLoading: Observable<Bool> {
        return activityIndicator.asSharedSequence().asObservable()
    }

    var didFinishFetch: Observable<Void> {
        return didFinishFetchSubject.asObservable()
    }

    func startOfMonth(date: Date) -> String {
        let startDay = date.startOf(component: .month)
        return shortDateFormatter.string(from: startDay)
    }

    func endOfMonth(date: Date) -> String {
        let endDay = date.endOf(component: .month)
        return shortDateFormatter.string(from: endDay)
    }

    func fetchData(for date: Date) {
        Observable.combineLatest(
            reportsService.getReports(startDate: startOfMonth(date: date), endDate: endOfMonth(date: date)),
            projectsService.getProjects(),
            holidaysService.getHolidays(month: date.month, year: date.year)
        ) { (reports: $0, projects: $1, holidays: $2) }
            .trackActivity(activityIndicator)
            .subscribe(onNext: { [weak self] (reports, projects, holidays) in
                self?.reportsSubject.onNext(reports)
                self?.projectsSubject.onNext(projects)
                self?.holidaysRelay.accept(holidays.days)
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
    private let holidaysRelay = BehaviorRelay<[Int]>(value: [])

    private let didFinishFetchSubject = PublishSubject<Void>()
    private let shortDateFormatter = DateFormatter.shortDateFormatter

}
