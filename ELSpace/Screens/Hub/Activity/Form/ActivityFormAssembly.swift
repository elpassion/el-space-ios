import UIKit

struct ActivityFormAssembly {

    func viewController(date: Date, report: ReportDTO?, projectScope: [ProjectDTO]) -> UIViewController & ActivityFormViewControlling {
        let viewModel = ActivityFormViewModel(date: date, report: report, projectScope: projectScope)
        return ActivityFormViewController(viewModel: viewModel)
    }

}
