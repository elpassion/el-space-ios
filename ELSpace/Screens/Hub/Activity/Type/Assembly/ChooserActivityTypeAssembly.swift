import UIKit

struct ChooserActivityTypeAssembly {

    func viewController() -> UIViewController & ChooserActivityTypesViewControlling {
        let viewModel = ChooserActivityTypesViewModel()
        return ChooserActivityTypesViewController(viewModel: viewModel)
    }

}
