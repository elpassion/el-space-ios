import UIKit
import RxSwift
import RxCocoa

protocol SelectionViewControlling {
    var openHubWithToken: Observable<String> { get }
    var openDebate: Observable<Void> { get }
}

class SelectionViewController: UIViewController, SelectionViewControlling {

    init(selectionController: SelectionControllerSignIn,
         alertFactory: AlertCreation,
         viewControllerPresenter: ViewControllerPresenting) {
        self.selectionController = selectionController
        self.alertFactory = alertFactory
        self.viewControllerPresenter = viewControllerPresenter
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func loadView() {
        view = SelectionView()
    }

    var selectionView: SelectionView {
        guard let selectionView = view as? SelectionView else { fatalError("Expected SelectionView but got \(type(of: view))") }
        return selectionView
    }

    // MARK: - SelectionViewControlling

    var openHubWithToken: Observable<String> {
        return openHubWithTokenSubject.asObservable()
    }

    var openDebate: Observable<Void> {
        return selectionView.debateButton.rx.tap.asObservable()
    }

    // MARK: - Private

    private let selectionController: SelectionControllerSignIn
    private let alertFactory: AlertCreation
    private let viewControllerPresenter: ViewControllerPresenting

    // MARK: - Error presenting

    private func presentError(error: Error) {
        let alert = alertFactory.messageAlertController(with: "Error", message: error.localizedDescription)
        viewControllerPresenter.present(viewController: alert, on: self)
    }

    // MARK: - Bindings

    private let openHubWithTokenSubject = PublishSubject<String>()

    private func setupBindings() {
        selectionView.hubButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.selectionController.signInToHub(success: { token in
                    self?.isLoading.accept(false)
                    self?.openHubWithTokenSubject.onNext(token)
                }, failure: { error in
                    self?.isLoading.accept(false)
                    self?.presentError(error: error)
                })
            }).disposed(by: disposeBag)

        selectionView.hubButton.rx.tap.asObservable()
            .map { true }
            .bind(to: isLoading)
            .disposed(by: disposeBag)

        isLoading.asObservable()
            .bind(to: loadingIndicator.rx.isLoading)
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

    // MARK: - Loading

    private let isLoading = BehaviorRelay(value: false)

    private(set) lazy var loadingIndicator: LoadingIndicator = {
        return LoadingIndicator(superView: self.view)
    }()

}
