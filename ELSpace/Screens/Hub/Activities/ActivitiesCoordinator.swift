import UIKit
import RxSwift

class ActivitiesCoordinator: Coordinator {

    init(activityCreator: ActivityViewControllerCreating,
         activitiesViewController: UIViewController & ActivitiesViewControlling,
         activitiesViewModel: ActivitiesViewModelProtocol,
         presenter: ViewControllerPresenting) {
        self.activityCreator = activityCreator
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

    private let activityCreator: ActivityViewControllerCreating
    private let activitiesViewController: UIViewController & ActivitiesViewControlling
    private let activitiesViewModel: ActivitiesViewModelProtocol
    private let presenter: ViewControllerPresenting

    // MARK: - Bindings

    private func bind(viewModel: ActivitiesViewModelProtocol, to viewController: UIViewController & ActivitiesViewControlling) {
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

        viewController.addActivity
            .subscribe(onNext: { [weak self] in
                self?.showActivity()
            }).disposed(by: disposeBag)

    }

    private let disposeBag = DisposeBag()

    private func showActivity() {
        let activityViewController = activityCreator.activityViewController()
        presenter.push(viewController: activityViewController, on: activitiesViewController)
    }

}
