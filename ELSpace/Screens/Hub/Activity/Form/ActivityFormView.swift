import UIKit
import Anchorage

class ActivityFormView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let dateTextView = TextView(title: "PERFORMED AT")
    let projectTextView = TextView(title: "PROJECT")
    let pickerView = UIPickerView()
    let hoursTextView = TextView(title: "HOURS")
    let commentTextView = TextView(title: "COMMENT")

    // MARK: - Privates

    private lazy var stackView = Factory.stackView(views: [self.dateTextView,
                                                   self.projectTextView,
                                                   self.pickerView,
                                                   self.hoursTextView,
                                                   self.commentTextView,
                                                   UIView(frame: .zero)])

    private func addSubviews() {
        addSubview(stackView)
    }

    private func setupLayout() {
        stackView.edgeAnchors == edgeAnchors + 16
    }

}

private extension ActivityFormView {
    struct Factory {

        static func stackView(views: [UIView]) -> UIStackView {
            let view = UIStackView(arrangedSubviews: views)
            view.axis = .vertical
            view.distribution = .fill
            view.spacing = 6
            return view
        }

    }
}
