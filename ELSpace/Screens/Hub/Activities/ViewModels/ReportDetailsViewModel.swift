import RxSwift

protocol ReportDetailsViewModelProtocol {
    var title: String? { get }
    var subtitle: String? { get }
    var type: ReportType? { get }
    var value: Double { get }
    var tapOnReportDetails: AnyObserver<Void> { get }
    var disposeBag: DisposeBag { get }
}

class ReportDetailsViewModel: ReportDetailsViewModelProtocol {

    init(report: ReportViewModelProtocol, project: ProjectDTO?) {
        self.report = report
        self.project = project
    }

    var didTapOnReportObservable: Observable<Void> {
        return didTapOnReportSubject.asObservable()
    }

    // MARK: - ReportDetailsViewModelProtocol

    var title: String? {
        return typeTitle
    }

    var subtitle: String? {
        return report.comment
    }

    var type: ReportType? {
        return ReportType(rawValue: report.type)
    }

    var value: Double {
        switch type {
        case .some(.normal): return report.value
        case .some(.paidVacations): return weekdaysHoursOfWork
        case .some(.unpaidDayOff): return weekdaysHoursOfWork
        case .some(.sickLeave): return weekdaysHoursOfWork
        default: return 0.0
        }
    }

    var tapOnReportDetails: AnyObserver<Void> {
        return didTapOnReportSubject.asObserver()
    }

    let disposeBag = DisposeBag()

    // MARK: - Private

    private let didTapOnReportSubject = PublishSubject<Void>()

    private let project: ProjectDTO?
    private let report: ReportViewModelProtocol
    private let weekdaysHoursOfWork: Double = 8.0

    private var typeTitle: String? {
        switch type {
        case .some(.normal):
            guard let projectName = project?.name else { return "\(report.value)" }
            return "\(projectName) - \(report.value)"
        case .some(.paidVacations): return "Vacations"
        default: return nil
        }
    }

}

enum ReportType: Int {
    case normal
    case paidVacations
    case unpaidDayOff
    case sickLeave
}
