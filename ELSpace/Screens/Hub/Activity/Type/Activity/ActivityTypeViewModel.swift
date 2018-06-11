import UIKit
import RxSwift
import RxCocoa

protocol ActivityTypeViewModeling: class {
    var type: ReportType { get }
    var imageSelected: UIImage? { get }
    var imageUnselected: UIImage? { get }
    var title: String { get }
    var isUserInteractionEnabled: Bool { get }
    var isSelected: BehaviorRelay<Bool> { get }
}

class ActivityTypeViewModel: ActivityTypeViewModeling {

    init(type: ReportType) {
        self.type = type
        imageSelected = type.imageSelected
        imageUnselected = type.imageUnselected
        title = type.title.uppercased()
        isUserInteractionEnabled = false
    }

    let type: ReportType
    let imageSelected: UIImage?
    let imageUnselected: UIImage?
    let title: String
    let isUserInteractionEnabled: Bool

    var isSelected = BehaviorRelay(value: false)

}

private extension ReportType {

    var imageSelected: UIImage? {
        switch self {
        case .normal: return UIImage(named: "time_report_selected")
        case .paidVacations: return UIImage(named: "vacation_selected")
        case .unpaidDayOff: return UIImage(named: "day_off_selected")
        case .sickLeave: return UIImage(named: "sick_leave_selected")
        case .conference: return UIImage(named: "conference_selected")
        }
    }

    var imageUnselected: UIImage? {
        switch self {
        case .normal: return UIImage(named: "time_report_unselected")
        case .paidVacations: return UIImage(named: "vacation_unselected")
        case .unpaidDayOff: return UIImage(named: "day_off_unselected")
        case .sickLeave: return UIImage(named: "sick_leave_unselected")
        case .conference: return UIImage(named: "conference_unselected")
        }
    }

    var title: String {
        switch self {
        case .normal: return "time report"
        case .paidVacations: return "vacation"
        case .unpaidDayOff: return "day off"
        case .sickLeave: return "sick leave"
        case .conference: return "conference"
        }
    }

}
