import RxSwift
import SwiftDate

protocol ActivityViewModelProtocol {
    var dataSource: Observable<[DailyReportViewModel]> { get }
    func getData()
}

class ActivityViewModel: ActivityViewModelProtocol {

    init(activityController: ActivityControlling) {
        self.activityController = activityController
        setupBindings()
    }

    func getData() {
        activityController.getReports(from: startOfCurrentMonth, to: endOfCurrentMonth)
        activityController.getProjects()
    }

    var dataSource: Observable<[DailyReportViewModel]> {
        return viewModels.asObservable()
    }

    // MARK: - Private

    private let activityController: ActivityControlling
    private let shortDateFormatter = DateFormatter.shortDateFormatter()

    private let projects = Variable<[ProjectDTO]>([])
    private let reports = Variable<[ReportViewModel]>([])
    private let viewModels = Variable<[DailyReportViewModel]>([])

    private var days: [Date] {
        return Date.dates(between: Date().startOf(component: .month),
                          and: Date().endOf(component: .month),
                          increment: 1.day)
    }

    private var startOfCurrentMonth: String {
        let date = Date().startOf(component: .month)
        return shortDateFormatter.string(from: date)
    }

    private var endOfCurrentMonth: String {
        let date = Date().endOf(component: .month)
        return shortDateFormatter.string(from: date)
    }

    private func createViewModels() {
        viewModels.value = days.map { date -> DailyReportViewModel in
            let reports = self.reports.value.filter { date.isInSameDayOf(date: $0.date) }
            let viewModel = DailyReportViewModel(date: date, reports: reports, projects: projects.value)
            return viewModel
        }
    }

    // MARK: Bindings

    private func setupBindings() {
        activityController.reports
            .map { $0.map { ReportViewModel(report: $0) } }
            .bind(to: reports)
            .disposed(by: disposeBag)

        activityController.projects
            .bind(to: projects)
            .disposed(by: disposeBag)

        activityController.didFinishFetch
            .subscribe(onNext: { [weak self] in
                self?.createViewModels()
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
