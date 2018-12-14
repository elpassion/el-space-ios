import UIKit
import Anchorage

class ModalViewControllerBackgroundView: UIView {

    init() {
        super.init(frame: .zero)
        addSubview(blurView)
        blurView.edgeAnchors == edgeAnchors
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    private let blurView = CustomIntensityVisualEffectView(effect: UIBlurEffect(style: .dark), intensity: 0.18)

}
