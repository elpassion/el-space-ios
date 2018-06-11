import UIKit

struct ActivityFormAssembly {

    func viewController(report: ReportDTO, projectScope: [ProjectDTO]) -> UIViewController & ActivityFormViewControlling {
        let viewModel = ActivityFormViewModel(report: report, projectScope: projectScope)
        return ActivityFormViewController(viewModel: viewModel)
    }

}
