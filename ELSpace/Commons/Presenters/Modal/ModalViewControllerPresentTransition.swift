import UIKit
import Anchorage

class ModalViewControllerPresentTransition<T: ViewAnimating>: NSObject, UIViewControllerAnimatedTransitioning {

    init(animator: T.Type) {
        self.animator = animator
    }

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let targetView = transitionContext.view(forKey: .to) else { return }
        transitionContext.containerView.addSubview(targetView)
        targetView.alpha = 0
        targetView.frame = transitionContext.containerView.bounds
        targetView.transform = CGAffineTransform(translationX: 0, y: 200)

        let backgroundView = ModalViewControllerBackgroundView()
        backgroundView.alpha = 0
        transitionContext.containerView.insertSubview(backgroundView, belowSubview: targetView)
        backgroundView.edgeAnchors == transitionContext.containerView.edgeAnchors

        animator.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                backgroundView.alpha = 1
                targetView.alpha = 1
                targetView.transform = .identity
            },
            completion: { _ in
                let didComplete = !transitionContext.transitionWasCancelled
                transitionContext.completeTransition(didComplete)
            }
        )
    }

    // MARK: - Privates

    private let duration: TimeInterval = 0.4
    private let animator: T.Type

}
