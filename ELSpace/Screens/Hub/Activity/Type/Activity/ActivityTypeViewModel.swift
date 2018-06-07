import UIKit
import RxSwift
import RxCocoa

protocol ActivityTypeViewModeling: class {
    var type: ReportType { get }
    var imageSelected: UIImage? { get }
    var imageUnselected: UIImage? { get }
    var title: String { get }
    var isSelected: BehaviorRelay<Bool> { get }
}

class ActivityTypeViewModel: ActivityTypeViewModeling {

    init(type: ReportType) {
        self.type = type
        switch type {
        case .normal:
            imageUnselected = UIImage(named: "time_report_unselected")
            imageSelected = UIImage(named: "time_report_selected")
            title = "TIME REPORT"
        case .paidVacations:
            imageUnselected = UIImage(named: "vacation_unselected")
            imageSelected = UIImage(named: "vacation_selected")
            title = "VACATION"
        case .unpaidDayOff:
            imageUnselected = UIImage(named: "day_off_unselected")
            imageSelected = UIImage(named: "day_off_selected")
            title = "DAY OFF"
        case .sickLeave:
            imageUnselected = UIImage(named: "sick_leave_unselected")
            imageSelected = UIImage(named: "sick_leave_selected")
            title = "SICK LEAVE"
        case .conference:
            imageUnselected = UIImage(named: "conference_unselected")
            imageSelected = UIImage(named: "conference_selected")
            title = "CONFERENCE"
        }
    }

    let type: ReportType
    let imageSelected: UIImage?
    let imageUnselected: UIImage?
    let title: String

    var isSelected = BehaviorRelay<Bool>(value: false)

}
