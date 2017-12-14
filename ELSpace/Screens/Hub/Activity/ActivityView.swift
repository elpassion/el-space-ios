import UIKit
import Anchorage

class ActivityView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var activityTypeView: UIView? {
        didSet {
            activityTypeContainer.subviews.forEach { $0.removeFromSuperview() }
            if let view = activityTypeView {
                activityTypeContainer.addSubview(view)
                view.edgeAnchors == activityTypeContainer.edgeAnchors
            }
        }
    }

    // MARK: Private

    private let activityTypeContainer = UIView(frame: .zero)

    private func addSubviews() {
        addSubview(activityTypeContainer)
    }

    private func setupLayout() {
        activityTypeContainer.topAnchor == topAnchor + 16
        activityTypeContainer.leadingAnchor == leadingAnchor + 16
        activityTypeContainer.trailingAnchor == trailingAnchor - 16
        activityTypeContainer.heightAnchor == 64
    }

}
