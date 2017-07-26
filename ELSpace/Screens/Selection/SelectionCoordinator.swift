import UIKit
import ELDebate
import RxSwift

class SelectionCoordinator: Coordinator {

    init(assembly: SelectionCoordinatorAssembly) {
        self.assembly = assembly
        self.selectionViewController = assembly.selectionViewController
        self.debateRunner = assembly.debateRunner
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return selectionViewController
    }

    // MARK: - Private

    private let assembly: SelectionCoordinatorAssembly
    private let selectionViewController: SelectionViewController
    private let debateRunner: DebateRunning

    // MARK: Presenting

    private func runDebate() {
        guard let navigationController = initialViewController.navigationController else { return }
        debateRunner.start(in: navigationController, applyingDebateStyle: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Bindings

    private func setupBindings() {
        selectionViewController.debateButtonTapObservable
            .subscribe(onNext: { [weak self] in
                self?.runDebate()
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
