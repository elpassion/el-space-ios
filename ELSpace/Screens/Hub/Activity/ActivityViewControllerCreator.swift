import UIKit

struct ActivityViewControllerCreator: ActivityViewControllerCreating {

    func activityViewController(date: Date, report: ReportDTO?, projectScope: [ProjectDTO]) -> UIViewController & ActivityViewControlling {
        return ActivityViewController(assembly: Assembly(date: date, report: report, projectScope: projectScope))
    }

    private struct Assembly: ActivityViewControllerAssembly {

        let date: Date
        let report: ReportDTO?
        let projectScope: [ProjectDTO]

        var typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling {
            return ChooserActivityTypeAssembly().viewController(report: report)
        }

        var formViewController: UIViewController & ActivityFormViewControlling {
            return ActivityFormAssembly().viewController(date: date, report: report, projectScope: projectScope)
        }

        var notificationCenter: NotificationCenter {
            return NotificationCenter.default
        }

    }
}

protocol ActivityViewControllerCreating {
    func activityViewController(date: Date, report: ReportDTO?, projectScope: [ProjectDTO]) -> UIViewController & ActivityViewControlling
}
