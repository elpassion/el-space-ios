import UIKit

protocol ModalViewControllerPresenting {
    func present(viewController: UIViewController, on baseViewController: UIViewController)
    func dismiss(viewController: UIViewController)
}

class ModalViewControllerPresenter: NSObject, ModalViewControllerPresenting, UIViewControllerTransitioningDelegate {

    init(configuration: ModalPresentationConfiguration) {
        self.configuration = configuration
    }

    // MARK: - ViewControllerPresenting

    func present(viewController: UIViewController, on baseViewController: UIViewController) {
        prepare(viewController)
        baseViewController.present(viewController, animated: true, completion: nil)
    }

    func dismiss(viewController: UIViewController) {
        prepare(viewController)
        viewController.dismiss(animated: true, completion: nil)
    }

    // MARK: - UIViewControllerTransitioningDelegate

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return configuration.presentTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return configuration.dismissTransition
    }

    // MARK: - Privates

    private let configuration: ModalPresentationConfiguration

    private func prepare(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = configuration.presentationStyle
        viewController.transitioningDelegate = self
    }

}
