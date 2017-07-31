import UIKit
import ELDebate
import RxSwift

class SelectionCoordinator: Coordinator {

    init(debateRunner: DebateRunning,
         viewController: UIViewController,
         selectionViewController: SelectionViewControlling) {
        self.debateRunner = debateRunner
        self.viewController = viewController
        self.selectionViewController = selectionViewController
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

    // MARK: - Presenting

    private func runDebate() {
        guard let navigationController = initialViewController.navigationController else { return }
        debateRunner.start(in: navigationController, applyingDebateStyle: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Bindings

    private func setupBindings() {
        selectionViewController.openHubWithToken
            .subscribe(onNext: { token in
                print(token)
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
