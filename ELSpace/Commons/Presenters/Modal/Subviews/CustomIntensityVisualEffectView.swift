import UIKit

class CustomIntensityVisualEffectView: UIVisualEffectView {

    init(effect: UIVisualEffect, intensity: CGFloat) {
        super.init(effect: nil)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in self.effect = effect }
        animator.fractionComplete = intensity
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    private var animator: UIViewPropertyAnimator!

}
