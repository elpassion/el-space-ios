import Foundation

class DailyReportViewModel {

    init(date: Date, reports: [ReportViewModel], projects: [ProjectDTO]) {
        self.date = date
        reportsViewModel = reports.map { report in
            let project = projects.first(where: { $0.id == report.id })
            let reportDetailsViewModel = ReportDetailsViewModel(report: report, project: project)
            return reportDetailsViewModel
        }
    }

    var day: String {
        return dayFormatter.string(from: date)
    }

    // MARK: - Private

    private let reportsViewModel: [ReportDetailsViewModel]
    private let dayFormatter = DateFormatter.dayFormatter()
    private let date: Date
    
}
