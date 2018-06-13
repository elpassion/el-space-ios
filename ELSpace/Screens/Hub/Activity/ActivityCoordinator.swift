import UIKit
import RxSwift

class ActivityCoordinator: Coordinator {

    init(viewController: UIViewController & ActivityViewControlling,
         viewModel: ActivityViewModelProtocol) {
        self.viewController = viewController
        self.viewModel = viewModel
        bind(viewModel: viewModel, to: viewController)
    }

    // MARK: Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: Private

    private let viewController: UIViewController & ActivityViewControlling
    private let viewModel: ActivityViewModelProtocol

    // MARK: Bindings

    private let disposeBag = DisposeBag()

    private func bind(viewModel: ActivityViewModelProtocol,
                      to viewController: UIViewController & ActivityViewControlling) {
        viewController.addActivity.bind(to: viewModel.addActivity).disposed(by: disposeBag)

        viewController.deleteAction.bind(to: viewModel.deleteAction).disposed(by: disposeBag)

        viewModel.isLoading.bind(to: viewController.isLoading).disposed(by: disposeBag)

        viewModel.dismiss
            .subscribe(onNext: { [weak viewController] in
                viewController?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }

}
