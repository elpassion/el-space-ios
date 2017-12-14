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
                view.edgeAnchors == activityTypeContainer.edgeAnchors + 8
            }
        }
    }

    // MARK: Private

    private let activityTypeContainer = Factory.activityTypeContainer()

    private func addSubviews() {
        addSubview(activityTypeContainer)
    }

    private func setupLayout() {
        activityTypeContainer.topAnchor == topAnchor + 16
        activityTypeContainer.leadingAnchor == leadingAnchor + 16
        activityTypeContainer.trailingAnchor == trailingAnchor - 16
        activityTypeContainer.heightAnchor == 80
    }

}

private extension ActivityView {
    struct Factory {

        static func activityTypeContainer() -> UIView {
            let view = UIView(frame: .zero)
            view.backgroundColor = .white
            view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            view.layer.shadowOpacity = 1
            view.layer.shadowRadius = 7
            view.layer.cornerRadius = 6
            return view
        }

    }
}
