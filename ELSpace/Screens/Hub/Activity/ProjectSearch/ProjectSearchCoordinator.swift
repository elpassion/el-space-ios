import UIKit
import RxSwift
import RxCocoa

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
    private let disposeBag = DisposeBag()

    // MARK: Binding

    private func bind(viewModel: ProjectSearchViewModelProtocol, to viewController: UIViewController & ProjectSearchViewControlling) {

        viewModel.projects
            .drive(viewController.projectRelay)
            .disposed(by: disposeBag)

        viewController.searchText
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)

        viewController.didSelectProject
            .bind(to: viewModel.selectProject)
            .disposed(by: disposeBag)
    }

}
