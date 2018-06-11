import UIKit

struct ChooserActivityTypeAssembly {

    func viewController(report: ReportDTO) -> UIViewController & ChooserActivityTypesViewControlling {
        let viewModel = ChooserActivityTypesViewModel(report: report)
        return ChooserActivityTypesViewController(viewModel: viewModel)
    }

}
