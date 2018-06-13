import UIKit

struct ChooserActivityTypeAssembly {

    func viewController(activityType: ActivityType) -> UIViewController & ChooserActivityTypesViewControlling {
        let viewModel = ChooserActivityTypesViewModel(activityType: activityType)
        return ChooserActivityTypesViewController(viewModel: viewModel)
    }

}
