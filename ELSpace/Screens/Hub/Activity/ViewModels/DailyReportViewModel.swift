import Foundation

class DailyReportViewModel {

    init(date: Date, reports: [ReportViewModel], projects: [ProjectDTO]) {
        self.date = date
        reportsViewModel = reports.map { report in
            let project = projects.first(where: { $0.id == report.projectId })
            let reportDetailsViewModel = ReportDetailsViewModel(report: report, project: project)
            return reportDetailsViewModel
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
        } else if date.isAfter(date: Date(), granularity: .day) && reportsViewModel.isEmpty {
            return DayType.missing
        } else {
            return DayType.comming
        }
    }

    func viewModelsContains(type: ReportType) -> Bool {
        return reportsViewModel.contains { viewModel -> Bool in viewModel.type == type }
    }

    let reportsViewModel: [ReportDetailsViewModel]

    // MARK: - Private

    private let dayFormatter = DateFormatter.dayFormatter()
    private let date: Date

}

enum DayType {
    case normal
    case weekend
    case missing
    case comming
}
