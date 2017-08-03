import RxSwift

protocol ActivityControlling {
    var reports: Observable<[ReportDTO]> { get }
    func getReports(from: String, to: String)
}

class ActivityController: ActivityControlling {

    init(reportsService: ReportsServiceProtocol) {
        self.reportsService = reportsService
    }

    // MARK: - ActivityControlling

    var reports: Observable<[ReportDTO]> {
        return reportsSubject.asObservable()
    }

    func getReports(from: String, to: String) {
        _ = reportsService.getReports(startDate: from, endDate: to)
            .subscribe(onNext: { [weak self] reports in
                self?.reportsSubject.onNext(reports)
        })
    }

    // MARK: - Private

    private let reportsService: ReportsServiceProtocol
    private let reportsSubject = PublishSubject<[ReportDTO]>()

}
