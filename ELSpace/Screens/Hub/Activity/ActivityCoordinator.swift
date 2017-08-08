import UIKit
import RxSwift

class ActivityCoordinator: Coordinator {

    init(viewController: ActivityViewController,
         viewModel: ActivityViewModelProtocol) {
        self.viewController = viewController
        self.viewModel = viewModel
        bind(viewModel: viewModel, to: viewController)
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: - Private

    private let viewController: ActivityViewController
    private let viewModel: ActivityViewModelProtocol

    // MARK: - Bindings

    func bind(viewModel: ActivityViewModelProtocol, to viewController: ActivityViewController) {
        viewController.rx.viewDidAppear
            .subscribe(onNext: { [weak self] in
                self?.viewModel.getData()
            }).disposed(by: disposeBag)

        viewModel.dataSource
            .subscribe(onNext: { [weak self] viewModels in
                self?.viewController.viewModels = viewModels
            }).disposed(by: disposeBag)

        viewModel.isLoading
            .bind(to: viewController.loadingIndicator.rx.isLoading)
            .disposed(by: disposeBag)

        viewModel.monthObservable
            .subscribe(onNext: { [weak self] month in
                self?.viewController.navigationItemTitle = month
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
