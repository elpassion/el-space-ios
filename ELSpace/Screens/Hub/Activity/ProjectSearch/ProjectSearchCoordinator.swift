import UIKit

class ProjectSearchCoordinator: Coordinator {

    init(projectSearchViewController: UIViewController & ProjectSearchViewControlling,
         projectSearchViewModel: ProjectSearchViewModelProtocol) {
        self.projectSearchViewController = projectSearchViewController
        self.projectSearchViewModel = projectSearchViewModel
        bind(viewModel: projectSearchViewModel, to: projectSearchViewController)
    }

    // MARK: Coordinator

    var initialViewController: UIViewController {
        return projectSearchViewController
    }

    // MARK: Privates

    private let projectSearchViewController: UIViewController & ProjectSearchViewControlling
    private let projectSearchViewModel: ProjectSearchViewModelProtocol

    // MARK: Binding

    private func bind(viewModel: ProjectSearchViewModelProtocol, to viewController: UIViewController & ProjectSearchViewControlling) {
        // @TODO
    }

}
