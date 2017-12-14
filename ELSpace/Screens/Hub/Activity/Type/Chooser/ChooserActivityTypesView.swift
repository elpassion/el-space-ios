import UIKit
import Anchorage

class ChooserActivityTypesView: UIView {

    init() {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var typeViews: [UIView]? {
        didSet {
            subviews.forEach { $0.removeFromSuperview() }
            if let typeViews = typeViews {
                let stackView = Factory.stackView()
                addSubview(stackView)
                stackView.edgeAnchors == edgeAnchors
                typeViews.forEach { stackView.addArrangedSubview($0) }
            }
        }
    }

}

private extension ChooserActivityTypesView {
    struct Factory {

        static func stackView() -> UIStackView {
            let view = UIStackView(arrangedSubviews: [])
            view.axis = .horizontal
            view.distribution = .fillEqually
            view.spacing = 6
            return view
        }

    }
}
