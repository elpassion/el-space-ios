import UIKit
import RxSwift

class ActivityCoordinator: Coordinator {

    init(viewController: ActivityViewController,
         viewModel: ActivityViewModelProtocol) {
        self.viewController = viewController
        self.viewModel = viewModel
        setupBindings()
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: - Private

    private let viewController: ActivityViewController
    private let viewModel: ActivityViewModelProtocol

    // MARK: - Bindings

    private func setupBindings() {
        viewController.rx.viewDidAppear
            .subscribe(onNext: { [weak self] in
                self?.viewModel.getReports()
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
