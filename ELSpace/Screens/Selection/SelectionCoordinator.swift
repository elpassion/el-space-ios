import UIKit
import ELDebate
import RxSwift

class SelectionCoordinator: Coordinator {

    init(debateRunner: DebateRunning,
         viewController: UIViewController,
         selectionViewController: SelectionViewControlling,
         activityCoordinatorFactory: ActivityCoordinatorCreation) {
        self.debateRunner = debateRunner
        self.viewController = viewController
        self.selectionViewController = selectionViewController
        self.activityCoordinatorFactory = activityCoordinatorFactory
        setupBindings()
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: - Private

    private let debateRunner: DebateRunning
    private let viewController: UIViewController
    private let selectionViewController: SelectionViewControlling
    private let activityCoordinatorFactory: ActivityCoordinatorCreation

    // MARK: - Presenting

    private func runDebate() {
        guard let navigationController = initialViewController.navigationController else { return }
        debateRunner.start(in: navigationController, applyingDebateStyle: true)
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.navigationBar.setBackgroundImage(nil, for: .default)
    }

    private func presentHub() {
        let coordinator = activityCoordinatorFactory.activityCoordinator()
        let navigationController = initialViewController.navigationController
        navigationController?.pushViewController(coordinator.initialViewController, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Bindings

    private func setupBindings() {
        selectionViewController.openHubWithToken
            .subscribe(onNext: { [weak self] token in
                self?.presentHub()
                print(token)
            }).disposed(by: disposeBag)

        selectionViewController.openDebate
            .subscribe(onNext: { [weak self] in
                self?.runDebate()
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
