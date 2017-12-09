import UIKit
import RxSwift

class ActivitiesCoordinator: Coordinator {

    init(viewController: UIViewController,
         activitiesViewController: ActivitiesViewControlling,
         viewModel: ActivitiesViewModelProtocol) {
        self.viewController = viewController
        self.activitiesViewController = activitiesViewController
        self.viewModel = viewModel
        bind(viewModel: viewModel, to: activitiesViewController)
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: - Private

    private let viewController: UIViewController
    private let activitiesViewController: ActivitiesViewControlling
    private let viewModel: ActivitiesViewModelProtocol

    // MARK: - Bindings

    func bind(viewModel: ActivitiesViewModelProtocol, to viewController: ActivitiesViewControlling) {
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
