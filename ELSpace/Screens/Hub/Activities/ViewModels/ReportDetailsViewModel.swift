import RxSwift

protocol ReportDetailsViewModelProtocol {
    var title: String? { get }
    var subtitle: String? { get }
    var type: ReportType? { get }
    var report: ReportViewModelProtocol { get }
    var action: PublishSubject<Void> { get }
    var hours: Double { get }
}

class ReportDetailsViewModel: ReportDetailsViewModelProtocol {

    init(report: ReportDTO, project: ProjectDTO?) {
        self.report = report
        self.project = project
    }

    // MARK: - ReportDetailsViewModelProtocol

    var title: String? {
        return typeTitle
    }

    var subtitle: String? {
        return report.comment
    }

    var type: ReportType? {
        return ReportType(rawValue: report.reportType)
    }

    var hours: Double {
        switch type {
        case .some(.normal): return doubleHours
        case .some(.paidVacations): return weekdaysHoursOfWork
        case .some(.unpaidDayOff): return weekdaysHoursOfWork
        case .some(.sickLeave): return weekdaysHoursOfWork
        default: return 0.0
        }
    }

    let report: ReportViewModelProtocol

    let action = PublishSubject<Void>()

    // MARK: - Private

    private let project: ProjectDTO?
    private let report: ReportDTO
    private let weekdaysHoursOfWork = 8.0

    private var typeTitle: String? {
        switch type {
        case .some(.normal):
            guard let projectName = project?.name else { return "\(report.value)" }
            return "\(projectName) - \(report.value)"
        case .some(.paidVacations): return "Vacations"
        default: return nil
        }
    }

    private var doubleHours: Double {
        guard let value = Double(report.value) else { return 0.0 }
        return value
    }

}

enum ReportType: Int {
    case normal
    case paidVacations
    case unpaidDayOff
    case sickLeave
}
