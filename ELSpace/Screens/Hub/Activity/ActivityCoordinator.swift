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
        viewController.addAction.bind(to: viewModel.addAction).disposed(by: disposeBag)
    }

}
