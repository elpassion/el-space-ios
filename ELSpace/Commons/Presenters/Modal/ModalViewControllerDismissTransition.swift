import UIKit

class ModalViewControllerDismissTransition<T: ViewAnimating>: NSObject, UIViewControllerAnimatedTransitioning {

    init(animator: T.Type) {
        self.animator = animator
    }

    // MARK: UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let targetView = transitionContext.view(forKey: .from) else { return }

        let backgroundView = transitionContext.containerView.subviews.first(where: {
            $0.isKind(of: ModalViewControllerBackgroundView.self)
        })

        animator.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                backgroundView?.alpha = 0
                targetView.alpha = 0
                targetView.transform = CGAffineTransform(translationX: 0, y: 200)
            },
            completion: { _ in
                backgroundView?.removeFromSuperview()
                targetView.removeFromSuperview()
                targetView.transform = .identity
                let didComplete = !transitionContext.transitionWasCancelled
                transitionContext.completeTransition(didComplete)
            }
        )
    }

    // MARK: Private

    private let duration: TimeInterval = 0.4
    private let animator: T.Type

}
