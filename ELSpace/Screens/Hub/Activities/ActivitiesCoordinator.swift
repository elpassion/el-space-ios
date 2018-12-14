import UIKit
import RxSwift

class ActivitiesCoordinator: Coordinator {

    init(activitiesViewController: UIViewController & ActivitiesViewControlling,
         monthPickerViewControllerFactory: MonthPickerViewControllerCreation,
         activitiesViewModel: ActivitiesViewModelProtocol,
         presenter: ViewControllerPresenting,
         modalPresenter: ModalViewControllerPresenting,
         activityCoordinatorFactory: ActivityCoordinatorCreation) {
        self.activitiesViewController = activitiesViewController
        self.monthPickerViewControllerFactory = monthPickerViewControllerFactory
        self.activitiesViewModel = activitiesViewModel
        self.presenter = presenter
        self.modalPresenter = modalPresenter
        self.activityCoordinatorFactory = activityCoordinatorFactory
        bind(viewModel: self.activitiesViewModel, to: self.activitiesViewController)
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return activitiesViewController
    }

    // MARK: - Private

    private let activityCoordinatorFactory: ActivityCoordinatorCreation
    private let monthPickerViewControllerFactory: MonthPickerViewControllerCreation
    private let activitiesViewController: UIViewController & ActivitiesViewControlling
    private let activitiesViewModel: ActivitiesViewModelProtocol
    private let presenter: ViewControllerPresenting
    private let modalPresenter: ModalViewControllerPresenting
    private var presentedCoordinator: Coordinator?

    // MARK: - Bindings

    private func bind(viewModel: ActivitiesViewModelProtocol, to viewController: UIViewController & ActivitiesViewControlling) {
        viewController.viewDidAppear
            .subscribe(onNext: { [weak self] in
                self?.activitiesViewModel.getData()
            }).disposed(by: disposeBag)

        viewController.changeMonth
            .drive(onNext: { [weak self] in
                self?.showMonthPicker(on: viewController)
            })
            .disposed(by: disposeBag)

        viewModel.dataSource
            .subscribe(onNext: { [weak viewController] viewModels in
                viewController?.viewModels = viewModels
            }).disposed(by: disposeBag)

        viewModel.isLoading
            .bind(to: viewController.isLoading)
            .disposed(by: disposeBag)

        viewModel.error
            .bind(to: viewController.error)
            .disposed(by: disposeBag)

        viewModel.month
            .subscribe(onNext: { [weak viewController] month in
                viewController?.navigationItemTitle = month
            }).disposed(by: disposeBag)

        viewModel.openReport
            .subscribe(onNext: { [weak self] in self?.showActivity(activityType: ActivityType.report($0.report), projects: $0.projects) })
            .disposed(by: disposeBag)

        viewModel.createReport
            .subscribe(onNext: { [weak self] in self?.showActivity(activityType: ActivityType.new($0.date), projects: $0.projects) })
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()
    private var monthPickerDisposeBag = DisposeBag()

    private func showActivity(activityType: ActivityType, projects: [ProjectDTO]) {
        let coordinator = activityCoordinatorFactory.activityCoordinator(activityType: activityType, projectScope: projects)
        presentedCoordinator = coordinator
        presenter.push(viewController: coordinator.initialViewController, on: activitiesViewController)
    }

    private func showMonthPicker(on viewController: UIViewController) {
        let monthPickerViewController = monthPickerViewControllerFactory.monthPicker()
        modalPresenter.present(viewController: monthPickerViewController, on: viewController)
        monthPickerViewController.dismiss
            .drive(onNext: { [weak self] in
                self?.modalPresenter.dismiss(viewController: monthPickerViewController)
                self?.monthPickerDisposeBag = DisposeBag()
            })
            .disposed(by: monthPickerDisposeBag)
    }

}
