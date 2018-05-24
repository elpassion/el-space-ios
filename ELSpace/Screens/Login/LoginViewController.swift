import UIKit
import RxSwift
import RxSwiftExt
import RxCocoa
import GoogleSignIn

protocol LoginViewControlling {
    var googleTooken: ((String) -> Void)? { get set }
}

class LoginViewController: UIViewController, LoginViewControlling {

    var googleTooken: ((String) -> Void)?

    init(googleUserManager: GoogleUserManaging,
         alertFactory: AlertCreation,
         viewControllerPresenter: ViewControllerPresenting,
         googleUserMapper: GoogleUserMapping) {
        self.googleUserManager = googleUserManager
        self.alertFactory = alertFactory
        self.viewControllerPresenter = viewControllerPresenter
        self.googleUserMapper = googleUserMapper
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
        view = LoginView()
    }

    var loginView: LoginView! {
        return view as? LoginView
    }

    // MARK: - Private

    private let googleUserManager: GoogleUserManaging
    private let alertFactory: AlertCreation
    private let viewControllerPresenter: ViewControllerPresenting
    private let googleUserMapper: GoogleUserMapping
    private let isSigningIn = BehaviorRelay(value: false)

    // MARK: - Bindings

    private func setupBindings() {
        loginView.loginButton.rx.tap
            .ignoreWhen { [weak self] in self?.isSigningIn.value == true }
            .subscribe(onNext: { [weak self] in
                self?.isSigningIn.accept(true)
                self?.signIn()
            }).disposed(by: disposeBag)

        googleUserManager.error
            .subscribe(onNext: { [weak self] error in
                self?.isSigningIn.accept(false)
                self?.handleError(error: error)
            }).disposed(by: disposeBag)

        googleUserManager.validationSuccess
            .subscribe(onNext: { [weak self] user in
                self?.isSigningIn.accept(false)
                self?.unwrapToken(user: user)
            }).disposed(by: disposeBag)

        isSigningIn.asObservable()
            .bind(to: loadingIndicator.rx.isLoading)
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

    // MARK: - Error handling

    private func handleError(error: Error) {
        guard let error = error as? EmailValidator.EmailValidationError else { return }
        present(error: error, on: self)
    }

    private func present(error: EmailValidator.EmailValidationError, on viewController: UIViewController) {
        let alert = alertFactory.messageAlertController(with: "Error", message: error.rawValue)
        viewControllerPresenter.present(viewController: alert, on: self)
    }

    // MARK: - Helpers

    private func unwrapToken(user: GIDGoogleUser) {
        let tokenId = googleUserMapper.getIdToken(user: user)
        googleTooken?(tokenId)
    }

    private func signIn() {
        googleUserManager.signIn(on: self)
    }

    // MARK: - Loading

    private(set) lazy var loadingIndicator: LoadingIndicator = {
        return LoadingIndicator(superView: self.view)
    }()

}
