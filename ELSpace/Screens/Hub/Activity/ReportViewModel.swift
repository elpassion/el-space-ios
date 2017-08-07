import UIKit

class ReportViewModel {

    init(report: ReportDTO) {
        self.report = report
    }

    var projectId: Int? {
        return report.projectId
    }

    var date: Date {
        guard let date = shortDateFormatter.date(from: report.performedAt) else { fatalError("Wrong date format") }
        return date
    }

    var value: Double {
        guard let value = Double(report.value) else { return 0.0 }
        return value
    }

    var comment: String? {
        return report.comment
    }

    var type: Int {
        return report.reportType
    }

    // MARK: - Private

    private let report: ReportDTO
    private let shortDateFormatter = DateFormatter.shortDateFormatter()

}
