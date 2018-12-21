import UIKit

class ViewControllerTransitionContextStub: NSObject, UIViewControllerContextTransitioning {

    var stubbedToView: UIView?
    var stubbedFromView: UIView?

    // MARK: - UIViewControllerContextTransitioning

    var containerView = UIView()
    var isAnimated = false
    var isInteractive = false
    var transitionWasCancelled = false
    var presentationStyle: UIModalPresentationStyle = .none
    private(set) var invokedCompleteTransition: (count: Int, didComplete: Bool)?

    func updateInteractiveTransition(_ percentComplete: CGFloat) {}

    func finishInteractiveTransition() {}

    func cancelInteractiveTransition() {}

    func pauseInteractiveTransition() {}

    func completeTransition(_ didComplete: Bool) {
        var count = invokedCompleteTransition?.count ?? 0
        count += 1

        invokedCompleteTransition = (count: count, didComplete: didComplete)
    }

    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        return nil
    }

    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        switch key {
        case UITransitionContextViewKey.from:
            return stubbedFromView
        case UITransitionContextViewKey.to:
            return stubbedToView
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
