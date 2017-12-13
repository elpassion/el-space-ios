import UIKit

class ActivityTypesView: UIView {

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
                typeViews.forEach { stackView.addArrangedSubview($0) }
            }
        }
    }
    
}

private extension ActivityTypesView {
    struct Factory {

        static func stackView() -> UIStackView {
            let view = UIStackView(arrangedSubviews: [])
            view.axis = .horizontal
            view.spacing = 6
            return view
        }

    }
}
