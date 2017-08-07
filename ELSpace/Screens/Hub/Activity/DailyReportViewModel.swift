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

    let reportsViewModel: [ReportDetailsViewModel]

    // MARK: - Private

    private let dayFormatter = DateFormatter.dayFormatter()
    private let date: Date

}
