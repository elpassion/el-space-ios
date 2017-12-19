import UIKit
import Anchorage

extension UIView {

    static func viewWithEmbeddedContent(_ contentView: UIView) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(contentView)
        contentView.edgeAnchors == view.edgeAnchors + 8
        return view
    }

}
