import UIKit

struct ActivityFormAssembly {

    func viewController() -> UIViewController & ActivityFormViewControlling {
        let viewModel = ActivityFormViewModel()
        return ActivityFormViewController(viewModel: viewModel)
    }

}
