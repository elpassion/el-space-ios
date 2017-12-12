import UIKit
import RxSwift

class ActivitiesCoordinator: Coordinator {

    init(activityViewController: UIViewController,
         activitiesViewController: UIViewController & ActivitiesViewControlling,
         activitiesViewModel: ActivitiesViewModelProtocol,
         presenter: ViewControllerPresenting) {
        self.activityViewController = activityViewController
        self.activitiesViewController = activitiesViewController
        self.activitiesViewModel = activitiesViewModel
        self.presenter = presenter
        bind(viewModel: self.activitiesViewModel, to: self.activitiesViewController)
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return activitiesViewController
    }

    // MARK: - Private

    private let activityViewController: UIViewController
    private let activitiesViewController: UIViewController & ActivitiesViewControlling
    private let activitiesViewModel: ActivitiesViewModelProtocol
    private let presenter: ViewControllerPresenting

    // MARK: - Bindings

    func bind(viewModel: ActivitiesViewModelProtocol, to viewController: UIViewController & ActivitiesViewControlling) {
        viewController.viewDidAppear
            .subscribe(onNext: { [weak self] in
                self?.activitiesViewModel.getData()
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
