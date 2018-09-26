import UIKit
import RxSwift

class SelectionCoordinator: Coordinator {

    init(viewController: UIViewController,
         selectionViewController: SelectionViewControlling,
         selectionScreenPresenter: SelectionScreenPresenting,
         hubSession: HubSession) {
        self.viewController = viewController
        self.selectionViewController = selectionViewController
        self.selectionScreenPresenter = selectionScreenPresenter
        self.hubSession = hubSession
        setupBindings()
    }

    // MARK: - Coordinator

    var initialViewController: UIViewController {
        return viewController
    }

    // MARK: - Private

    private let viewController: UIViewController
    private let selectionViewController: SelectionViewControlling
    private let selectionScreenPresenter: SelectionScreenPresenting
    private let hubSession: HubSession

    // MARK: - Bindings

    private func setupBindings() {
        selectionViewController.openHubWithToken
            .subscribe(onNext: { [weak self] token in
                self?.hubSession.accessToken = token
                self?.selectionScreenPresenter.presentHub()
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
