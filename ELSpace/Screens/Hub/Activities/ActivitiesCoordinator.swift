import UIKit
import RxSwift

class ActivitiesCoordinator: Coordinator {

    init(activitiesViewController: UIViewController & ActivitiesViewControlling,
         activitiesViewModel: ActivitiesViewModelProtocol,
         presenter: ViewControllerPresenting,
         activityCoordinatorFactory: ActivityCoordinatorCreation) {
        self.activitiesViewController = activitiesViewController
        self.activitiesViewModel = activitiesViewModel
        self.presenter = presenter
        self.activityCoordinatorFactory = activityCoordinatorFactory
        bind(viewModel: self.activitiesViewModel, to: self.activitiesViewController)
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return activitiesViewController
    }

    // MARK: - Private

    private let activityCoordinatorFactory: ActivityCoordinatorCreation
    private let activitiesViewController: UIViewController & ActivitiesViewControlling
    private let activitiesViewModel: ActivitiesViewModelProtocol
    private let presenter: ViewControllerPresenting
    private var presentedCoordinator: Coordinator?

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

        viewModel.openReport.debug()
            .subscribe(onNext: { [weak self] in self?.showActivity(report: $0.report, projects: $0.projects) })
            .disposed(by: disposeBag)

        viewModel.openActivity.debug()
            .subscribe(onNext: { [weak self] in
                guard let firstActivity = $0.first else { return }
                self?.showActivity(report: firstActivity, projects: []) })
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

    private func showActivity(report: ReportDTO, projects: [ProjectDTO]) {
        let coordinator = activityCoordinatorFactory.activityCoordinator(report: report, projectScope: projects)
        presentedCoordinator = coordinator
        presenter.push(viewController: coordinator.initialViewController, on: activitiesViewController)
    }

}
