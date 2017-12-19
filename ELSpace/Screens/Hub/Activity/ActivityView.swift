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

//    var activityTypeView: UIView? {
//        didSet {
//            activityTypeContainer.subviews.forEach { $0.removeFromSuperview() }
//            if let view = activityTypeView {
//                activityTypeContainer.addSubview(view)
//                view.edgeAnchors == activityTypeContainer.edgeAnchors + 8
//            }
//        }
//    }
//
//    var activityFormView: UIView? {
//        didSet {
//            activityFormContainer.subviews.forEach { $0.removeFromSuperview() }
//            if let view = activityFormView {
//                activityFormContainer.addSubview(view)
//                view.edgeAnchors == activityFormContainer.edgeAnchors + 8
//            }
//        }
//    }

    let stackView = Factory.stackView()

    // MARK: Private

//    private let activityTypeContainer = Factory.container()
//    private let activityFormContainer = Factory.container()

    private func addSubviews() {
        addSubview(stackView)
//        addSubview(activityTypeContainer)
//        addSubview(activityFormContainer)
    }

    private func setupLayout() {
        stackView.topAnchor == topAnchor + 16
        stackView.leadingAnchor == leadingAnchor + 16
        stackView.trailingAnchor == trailingAnchor - 16
//        activityTypeContainer.topAnchor == topAnchor + 16
//        activityTypeContainer.leadingAnchor == leadingAnchor + 16
//        activityTypeContainer.trailingAnchor == trailingAnchor - 16
//        activityTypeContainer.heightAnchor == 80
//
//        activityFormContainer.topAnchor == activityTypeContainer.bottomAnchor + 16
//        activityFormContainer.leadingAnchor == leadingAnchor + 16
//        activityFormContainer.trailingAnchor == trailingAnchor - 16
    }

}

private extension ActivityView {
    struct Factory {

//        static func container() -> UIView {
//            let view = UIView(frame: .zero)
//            view.backgroundColor = .white
//            view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
//            view.layer.shadowOffset = CGSize(width: 0, height: 4)
//            view.layer.shadowOpacity = 1
//            view.layer.shadowRadius = 7
//            view.layer.cornerRadius = 6
//            return view
//        }

        static func stackView() -> UIStackView {
            let view = UIStackView(arrangedSubviews: [])
            view.axis = .horizontal
            view.distribution = .fill
            view.spacing = 16
            return view
        }

    }
}
