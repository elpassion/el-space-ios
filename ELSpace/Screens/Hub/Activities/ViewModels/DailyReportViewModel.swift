import RxSwift

protocol DailyReportViewModelProtocol {
    var title: String? { get }
    var day: String { get }
    var dayType: DayType { get }
    var stripeColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var topCornersRounded: Bool { get }
    var bottomCornersRounded: Bool { get }
    var isSeparatorHidden: Bool { get }
    var didTapOnReport: PublishSubject<Void> { get }
    var reportsViewModel: [ReportDetailsViewModelProtocol] { get }
    var disposeBag: DisposeBag { get }
}

class DailyReportViewModel: NSObject, DailyReportViewModelProtocol {

    init(date: Date, todayDate: Date, reports: [ReportViewModelProtocol], projects: [ProjectDTO]) {
        self.date = date
        self.todayDate = todayDate
        reportsViewModel = reports.map { report in
            let project = projects.first(where: { $0.id == report.projectId })
            let reportDetailsViewModel = ReportDetailsViewModel(report: report, project: project)
            return reportDetailsViewModel
        }
    }

    // MARK: - DailReportViewModelProtocol

    var title: String? {
        switch dayType {
        case .weekday: return weekdayTitle
        case .missing: return "Missing"
        case .comming: return nil
        case .weekend: return "Weekend!"
        }
    }

    var day: String {
        return dayFormatter.string(from: date)
    }

    var dayType: DayType {
        if hasReports {
            return .weekday
        } else if date.isInWeekend {
            return .weekend
        } else if date.isBefore(date: todayDate, granularity: .day) && reportsViewModel.isEmpty {
            return .missing
        } else {
            return .comming
        }
    }

    var stripeColor: UIColor {
        switch dayType {
        case .weekday: return UIColor(color: .green92ECB4)
        case .missing: return UIColor(color: .brownBA6767)
        case .comming: return UIColor(color: .grayE4E4E4)
        case .weekend: return .clear
        }
    }

    var backgroundColor: UIColor {
        switch dayType {
        case .weekend: return .clear
        case .missing, .comming, .weekday: return .white
        }
    }

    var topCornersRounded = false
    var bottomCornersRounded = false
    var isSeparatorHidden = false

    var hasReports: Bool {
        return reportsViewModel.isEmpty == false
    }

    let didTapOnReport = PublishSubject<Void>()
    let reportsViewModel: [ReportDetailsViewModelProtocol]
    let disposeBag = DisposeBag()

    // MARK: - Private

    private let date: Date
    private let todayDate: Date

    private var dayValue: Double {
        return reportsViewModel.reduce(0.0) { (result, viewModel) -> Double in viewModel.value + result }
    }

    private let dayFormatter = DateFormatter.dayFormatter

    // MARK: Helpers

    private var viewModelsContainsUnpaidVacations: Bool {
        return reportsViewModel.contains(where: { viewModel -> Bool in viewModel.type == .unpaidDayOff })
    }

    private var viewModelsContainsSickLeave: Bool {
        return reportsViewModel.contains(where: { viewModel -> Bool in viewModel.type == .sickLeave })
    }

    private var weekdayTitle: String {
        if viewModelsContainsUnpaidVacations {
            return "Unpaid vacations"
        } else if viewModelsContainsSickLeave {
            return "Sick leave"
        } else {
            return "Total: \(dayValue) hours"
        }
    }

}

enum DayType {
    case weekday
    case weekend
    case missing
    case comming
}
