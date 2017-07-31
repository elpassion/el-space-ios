//
//  Created by Michał Czerniakowski on 08.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import RxSwift

protocol SelectionViewControlling {
    var openHubWithToken: Observable<String> { get }
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
                    self?.openHubWithTokenSubject.onNext(token)
                }, failure: { error in
                    self?.presentError(error: error)
                })
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
