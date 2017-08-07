import UIKit

class ReportViewModel {

    init(report: ReportDTO) {
        self.report = report
    }

    var id: Int {
        return report.id
    }

    var date: Date {
        guard let date = shortDateFormatter.date(from: report.performedAt) else { fatalError("Wrong date format") }
        return date
    }

    var value: Int {
        guard let value = Int(report.value) else { return 0 }
        return value
    }

    var comment: String? {
        return report.comment
    }

    // MARK: - Private

    private let report: ReportDTO
    private let shortDateFormatter = DateFormatter.shortDateFormatter()

}
