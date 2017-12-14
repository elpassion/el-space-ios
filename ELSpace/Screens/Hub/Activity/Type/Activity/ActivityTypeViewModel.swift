import UIKit
import RxSwift

class ActivityTypeViewModel: ActivityTypeViewModeling {

    init(type: ActivityType) {
        self.type = type
        switch type {
        case .timeReport:
            imageUnselected = UIImage(named: "airplane")
            imageSelected = UIImage(named: "money_selected")
            title = "TIME REPORT"
        case .vacation:
            imageUnselected = UIImage(named: "airplane")
            imageSelected = UIImage(named: "money_selected")
            title = "VACATION"
        case .dayOff:
            imageUnselected = UIImage(named: "airplane")
            imageSelected = UIImage(named: "money_selected")
            title = "DAY OFF"
        case .sickLeave:
            imageUnselected = UIImage(named: "airplane")
            imageSelected = UIImage(named: "money_selected")
            title = "SICK LEAVE"
        case .conference:
            imageUnselected = UIImage(named: "airplane")
            imageSelected = UIImage(named: "money_selected")
            title = "CONFERENCE"
        }
    }

    let type: ActivityType
    let imageSelected: UIImage?
    let imageUnselected: UIImage?
    let title: String

    var isSelected = PublishSubject<Bool>()

}
