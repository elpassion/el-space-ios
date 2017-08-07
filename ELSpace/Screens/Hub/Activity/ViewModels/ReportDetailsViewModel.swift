import Foundation

class ReportDetailsViewModel {

    var title: String? {
        guard let projectName = project?.name else { return nil }
        return "\(projectName) - \(report.value)"
    }

    var subtitle: String? {
        return report.comment
    }

    var type: ReportType? {
        return ReportType(rawValue: report.type)
    }

    init(report: ReportViewModel, project: ProjectDTO?) {
        self.report = report
        self.project = project
    }

    let report: ReportViewModel

    // MARK: - Private

    private let project: ProjectDTO?

}

enum ReportType: Int {
    case normal
    case paidVacations
    case unpaidDayOff
    case sickLeave
}
