import RxSwift

protocol DailyReportViewModelProtocol {
    var title: NSAttributedString? { get }
    var day: NSAttributedString { get }
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

    var hasReports: Bool {
        return !reportsViewModel.isEmpty
    }

    var isWeekendWithoutReports: Bool {
        return reportsViewModel.isEmpty && dayType == .weekend
    }

    // MARK: - DailReportViewModelProtocol

    var title: NSAttributedString? {
        switch dayType {
        case .weekday: return weekdayTitle
        case .missing: return NSAttributedString(string: "Missing", attributes: missingAttributes)
        case .comming: return nil
        case .weekend: return NSAttributedString(string: "Weekend!", attributes: weekendTitleAttributes)
        }
    }

    var day: NSAttributedString {
        let date = dayFormatter.string(from: self.date)
        if dayType == .weekend {
            return NSAttributedString(string: date, attributes: weekendDayAttributes)
        }
        return NSAttributedString(string: date, attributes: regularReportTimeAttributes)
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
        case .missing: return UIColor(color: .redBA6767)
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

    private var weekdayTitle: NSAttributedString {
        if viewModelsContainsUnpaidVacations {
            return NSAttributedString(string: "Unpaid vacations", attributes: bookFontAttributes)
        } else if viewModelsContainsSickLeave {
            return NSAttributedString(string: "Sick leave", attributes: bookFontAttributes)
        } else {
            return normalReportText()
        }
    }

    private func normalReportText() -> NSAttributedString {
        let text = NSMutableAttributedString(string: "Total: ", attributes: bookFontAttributes)
        let hoursText = NSAttributedString(string: "\(dayValue) hours", attributes: regularReportTimeAttributes)
        text.append(hoursText)
        return text
    }

    private var bookFontAttributes: [NSAttributedStringKey: Any] {
        return [
            NSAttributedStringKey.font: UIFont(name: "Gotham-Book", size: 16) ?? UIFont.systemFont(ofSize: 16),
            NSAttributedStringKey.foregroundColor: UIColor(color: .black5F5A6A)
        ]
    }

    private var regularReportTimeAttributes: [NSAttributedStringKey: Any] {
        return [
            NSAttributedStringKey.font: UIFont(name: "Gotham-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16),
            NSAttributedStringKey.foregroundColor: UIColor(color: .black5F5A6A)
        ]
    }

    private var missingAttributes: [NSAttributedStringKey: Any] {
        return [
            NSAttributedStringKey.font: UIFont(name: "Gotham-Book", size: 16) ?? UIFont.systemFont(ofSize: 16),
            NSAttributedStringKey.foregroundColor: UIColor(color: .redBA6767)
        ]
    }

    private var weekendDayAttributes: [NSAttributedStringKey: Any] {
        return [
            NSAttributedStringKey.font: UIFont(name: "Gotham-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16),
            NSAttributedStringKey.foregroundColor: UIColor(color: .grayB3B3B8)
        ]
    }

    private var weekendTitleAttributes: [NSAttributedStringKey: Any] {
        return [
            NSAttributedStringKey.font: UIFont(name: "Gotham-Book", size: 16) ?? UIFont.systemFont(ofSize: 16),
            NSAttributedStringKey.foregroundColor: UIColor(color: .grayB3B3B8)
        ]
    }

}

enum DayType {
    case weekday
    case weekend
    case missing
    case comming
}
