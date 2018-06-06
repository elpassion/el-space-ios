import UIKit

struct ActivityViewControllerCreator: ActivityViewControllerCreating {

    func activityViewController(report: ReportDTO, projectScope: [ProjectDTO]) -> UIViewController & ActivityViewControlling {
        return ActivityViewController(assembly: Assembly(report: report, projectScope: projectScope))
    }

    private struct Assembly: ActivityViewControllerAssembly {

        let report: ReportDTO
        let projectScope: [ProjectDTO]

        var typeChooserViewController: UIViewController & ChooserActivityTypesViewControlling {
            return ChooserActivityTypeAssembly().viewController()
        }

        var formViewController: UIViewController & ActivityFormViewControlling {
            return ActivityFormAssembly().viewController(report: report, projectScope: projectScope)
        }

        var notificationCenter: NotificationCenter {
            return NotificationCenter.default
        }

    }
}

protocol ActivityViewControllerCreating {
    func activityViewController(report: ReportDTO, projectScope: [ProjectDTO]) -> UIViewController & ActivityViewControlling
}
