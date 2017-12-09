import UIKit

protocol ReportViewModelProtocol {
    var projectId: Int? { get }
    var date: Date { get }
    var value: Double { get }
    var comment: String? { get }
    var type: Int { get }
}

class ReportViewModel: ReportViewModelProtocol {

    init(report: ReportDTO) {
        self.report = report
    }

    // MARK: - ReportViewModelProtocol

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
    private let shortDateFormatter = DateFormatter.shortDateFormatter

}
