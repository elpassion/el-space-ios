import UIKit
import RxSwift

class ActivityCoordinator: Coordinator {

    init(viewController: UIViewController,
         activityViewController: ActivityViewControlling,
         viewModel: ActivityViewModelProtocol) {
        self.viewController = viewController
        self.activityViewController = activityViewController
        self.viewModel = viewModel
        bind(viewModel: viewModel, to: activityViewController)
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: - Private

    private let viewController: UIViewController
    private let activityViewController: ActivityViewControlling
    private let viewModel: ActivityViewModelProtocol

    // MARK: - Bindings

    func bind(viewModel: ActivityViewModelProtocol, to viewController: ActivityViewControlling) {
        viewController.viewDidAppear
            .subscribe(onNext: { [weak self] in
                self?.viewModel.getData()
            }).disposed(by: disposeBag)

        viewModel.dataSource
            .subscribe(onNext: { [weak viewController] viewModels in
                viewController?.viewModels = viewModels
            }).disposed(by: disposeBag)

        viewModel.isLoading
            .bind(to: viewController.isLoading)
            .disposed(by: disposeBag)

        viewModel.monthObservable
            .subscribe(onNext: { [weak viewController] month in
                viewController?.navigationItemTitle = month
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
