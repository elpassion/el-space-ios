import UIKit
import RxSwift

protocol ActivityTypeViewModeling: class {
    var type: ActivityType { get }
    var imageSelected: UIImage? { get }
    var imageUnselected: UIImage? { get }
    var title: String { get }
    var isSelected: PublishSubject<Bool> { get }
}

class ActivityTypeViewModel: ActivityTypeViewModeling {

    init(type: ActivityType) {
        self.type = type
        switch type {
        case .timeReport:
            imageUnselected = UIImage(named: "time_report_unselected")
            imageSelected = UIImage(named: "time_report_selected")
            title = "TIME REPORT"
        case .vacation:
            imageUnselected = UIImage(named: "vacation_unselected")
            imageSelected = UIImage(named: "vacation_selected")
            title = "VACATION"
        case .dayOff:
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

    let type: ActivityType
    let imageSelected: UIImage?
    let imageUnselected: UIImage?
    let title: String

    var isSelected = PublishSubject<Bool>()

}
