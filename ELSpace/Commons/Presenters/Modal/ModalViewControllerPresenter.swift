import UIKit

protocol ModalViewControllerPresenting {
    func present(viewController: UIViewController, on baseViewController: UIViewController)
    func dismiss(viewController: UIViewController)
}

class ModalViewControllerPresenter: NSObject, ModalViewControllerPresenting, UIViewControllerTransitioningDelegate {

    init(presentTransition: @escaping () -> UIViewControllerAnimatedTransitioning?,
         dismissTransition: @escaping () -> UIViewControllerAnimatedTransitioning?) {
        self.presentTransition = presentTransition
        self.dismissTransition = dismissTransition
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
        return presentTransition()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition()
    }

    // MARK: - Privates

    private let presentTransition: () -> UIViewControllerAnimatedTransitioning?
    private let dismissTransition: () -> UIViewControllerAnimatedTransitioning?

    private func prepare(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .overFullScreen
        viewController.transitioningDelegate = self
    }

}
