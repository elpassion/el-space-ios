import UIKit
import ELDebate
import RxSwift

class SelectionCoordinator: Coordinator {

    init(assembly: SelectionCoordinatorAssembly,
         googleIdToken: String) {
        self.assembly = assembly
        self.selectionViewController = assembly.selectionViewController
        self.debateRunner = assembly.debateRunner
        self.selectionController = assembly.selectionController(googleIdToken: googleIdToken)
        setupBindings()
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return selectionViewController
    }

    // MARK: - Private

    private let assembly: SelectionCoordinatorAssembly
    private let selectionViewController: SelectionViewController
    private let debateRunner: DebateRunning
    private let selectionController: SelectionControllerSignIn

    // MARK: Presenting

    private func runDebate() {
        guard let navigationController = initialViewController.navigationController else { return }
        debateRunner.start(in: navigationController, applyingDebateStyle: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }

    private func presentError(error: Error) {
        let alertController = assembly.messageAlertController(message: error.localizedDescription)
        initialViewController.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Bindings

    private func setupBindings() {
        selectionViewController.openDebate
            .subscribe(onNext: { [weak self] in
                self?.runDebate()
            }).disposed(by: disposeBag)

        selectionViewController.openHub
            .subscribe(onNext: { [weak self] in
                self?.signInToHub()
            }).disposed(by: disposeBag)
    }

    private func signInToHub() {
        selectionController.signInToHub(success: { hubToken in
            print("HUB TOKEN: \(hubToken)")
        }) { [weak self] error in
            self?.presentError(error: error)
        }
    }

    private let disposeBag = DisposeBag()

}
