import UIKit

class ReportDetailsViewModel {

    var title: String? {
        guard let projectName = project?.name else { return nil }
        return "\(projectName) - \(report.value)"
    }

    var subtitle: String? {
        return report.comment
    }

    init(report: ReportViewModel, project: ProjectDTO?) {
        self.report = report
        self.project = project
    }

    // MARK: - Private

    private let report: ReportViewModel
    private let project: ProjectDTO?
    
}
