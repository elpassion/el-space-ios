import UIKit

class ViewControllerTransitionContextStub: NSObject, UIViewControllerContextTransitioning {

    var toView: UIView?
    var fromView: UIView?

    // MARK: - UIViewControllerContextTransitioning

    var containerView = UIView()
    var isAnimated = false
    var isInteractive = false
    var transitionWasCancelled = false
    var presentationStyle: UIModalPresentationStyle = .none

    func updateInteractiveTransition(_ percentComplete: CGFloat) {}

    func finishInteractiveTransition() {}

    func cancelInteractiveTransition() {}

    func pauseInteractiveTransition() {}

    func completeTransition(_ didComplete: Bool) {}

    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        return nil
    }

    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        switch key {
        case UITransitionContextViewKey.from:
            return fromView
        case UITransitionContextViewKey.to:
            return toView
        default:
            return nil
        }
    }

    var targetTransform: CGAffineTransform = .identity

    func initialFrame(for vc: UIViewController) -> CGRect {
        return .zero
    }

    func finalFrame(for vc: UIViewController) -> CGRect {
        return .zero
    }

}
