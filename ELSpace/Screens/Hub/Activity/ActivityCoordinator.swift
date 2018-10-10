import UIKit
import RxSwift

class ActivityCoordinator: Coordinator {

    init(viewController: UIViewController & ActivityViewControlling,
         viewModel: ActivityViewModelProtocol,
         projectSearchCoordinatorFactory: ProjectSearchCoordinatorCreation,
         presenter: ViewControllerPresenting) {
        self.viewController = viewController
        self.viewModel = viewModel
        self.projectSearchCoordinatorFactory = projectSearchCoordinatorFactory
        self.presenter = presenter
        bind(viewModel: viewModel, to: viewController)
    }

    // MARK: Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: Private

    private let viewController: UIViewController & ActivityViewControlling
    private let viewModel: ActivityViewModelProtocol
    private let projectSearchCoordinatorFactory: ProjectSearchCoordinatorCreation
    private let presenter: ViewControllerPresenting

    // MARK: Bindings

    private let disposeBag = DisposeBag()

    private func bind(viewModel: ActivityViewModelProtocol,
                      to viewController: UIViewController & ActivityViewControlling) {
        viewController.addActivity.bind(to: viewModel.addActivity).disposed(by: disposeBag)
        viewController.updateActivity.bind(to: viewModel.updateActivity).disposed(by: disposeBag)
        viewController.deleteAction.bind(to: viewModel.deleteAction).disposed(by: disposeBag)
        viewModel.isLoading.bind(to: viewController.isLoading).disposed(by: disposeBag)
        viewModel.error.bind(to: viewController.showError).disposed(by: disposeBag)

        viewModel.dismiss
            .subscribe(onNext: { [weak viewController] in
                viewController?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)

        viewController.formViewController.projectSelected
            .subscribe(onNext: { [weak self] in self?.showProjectSearch(projectId: $0) })
            .disposed(by: disposeBag)
    }

    private func showProjectSearch(projectId: Int?) {
        let projectSearchCoordinator = projectSearchCoordinatorFactory.projectSearchCoordinator(projectId: projectId)
        presenter.push(viewController: projectSearchCoordinator.initialViewController, on: self.viewController)
    }

}
