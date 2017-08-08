import RxSwift

protocol DailyReportViewModelProtocol {
    var title: String? { get }
    var day: String { get }
    var dayType: DayType { get }
    var reportsViewModel: [ReportDetailsViewModel] { get }
}

class DailyReportViewModel: DailyReportViewModelProtocol {

    init(date: Date, reports: [ReportViewModel], projects: [ProjectDTO]) {
        self.date = date
        reportsViewModel = reports.map { report in
            let project = projects.first(where: { $0.id == report.projectId })
            let reportDetailsViewModel = ReportDetailsViewModel(report: report, project: project)
            return reportDetailsViewModel
        }
    }

    var title: String? {
        switch dayType {
        case .missing: return "Missing"
        case .comming: return nil
        case .normal: return "Total: \(dayValue) hours"
        case .weekend: return "Weekend!"
        }
    }

    var day: String {
        return dayFormatter.string(from: date)
    }

    var dayType: DayType {
        if viewModelsContains(type: .normal) {
            return DayType.normal
        } else if date.isInWeekend {
            return DayType.weekend
        } else if date.isBefore(date: Date(), granularity: .day) && reportsViewModel.isEmpty {
            return DayType.missing
        } else {
            return DayType.comming
        }
    }

    let reportsViewModel: [ReportDetailsViewModel]

    // MARK: - Private

    private var dayValue: Double {
        return reportsViewModel.reduce(0.0) { (result, viewModel) -> Double in viewModel.report.value + result }
    }

    private let dayFormatter = DateFormatter.dayFormatter()
    private let date: Date

    private func viewModelsContains(type: ReportType) -> Bool {
        return reportsViewModel.contains { viewModel -> Bool in viewModel.type == type }
    }

}

enum DayType {
    case normal
    case weekend
    case missing
    case comming
}

extension DailyReportViewModelProtocol {

    var titleObservable: Observable<String?> {
        return Observable.just(title)
    }

    var dayObservable: Observable<String> {
        return Observable.just(day)
    }

    var dayTypeObservable: Observable<DayType> {
        return Observable.just(dayType)
    }

    var reportsViewModelObservable: Observable<[ReportDetailsViewModel]> {
        return Observable.just(reportsViewModel)
    }

}
