import UIKit
import Anchorage

class TextView: UIView {

    init(title: String) {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        titleLabel.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let textField = Factory.textField()
    let separatorLine = UIView(frame: .zero)

    // MARK: - Privates

    private let titleLabel = Factory.titleLabel()

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(separatorLine)
    }

    private func setupLayout() {
        titleLabel.topAnchor == topAnchor
        titleLabel.leadingAnchor == leadingAnchor

        textField.topAnchor == titleLabel.bottomAnchor + 4
        textField.horizontalAnchors == horizontalAnchors
        textField.heightAnchor == 44 ~ .high

        separatorLine.topAnchor == textField.bottomAnchor + 4
        separatorLine.horizontalAnchors == horizontalAnchors
        separatorLine.heightAnchor == 0.5 ~ .high
        separatorLine.bottomAnchor == bottomAnchor
    }

}

private extension TextView {
    struct Factory {

        static func titleLabel() -> UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Helvetica", size: 7)
            label.textColor = UIColor(color: .purpleBCAEF8)
            return label
        }

        static func textField() -> UITextField {
            let textField = UITextField(frame: .zero)
            textField.textColor = UIColor(color: .black5F5A6A)
            textField.font = UIFont(name: "Helvetica", size: 16)
            return textField
        }

    }
}
