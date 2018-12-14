import UIKit
import Anchorage
import RxSwift
import RxCocoa

class BottomMenuHeaderView: UIView {

    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }

    var doneButtonTitle: String? {
        get { return doneButton.title(for: .normal) }
        set { doneButton.setTitle(newValue, for: .normal) }
    }

    var doneButtonTap: ControlEvent<Void> {
        return doneButton.rx.controlEvent(.touchUpInside)
    }

    // MARK: Subviews

    let doneButton = Button(frame: .zero)
    private let titleLabel = UILabel()

    private func setupSubviews() {
        backgroundColor = .white

        addSubview(titleLabel)
        titleLabel.textColor = UIColor(color: .black5F5A6A)

        addSubview(doneButton)
        doneButton.contentEdgeInsets = UIEdgeInsets(top: 1, left: 16, bottom: 0, right: 16)
        doneButton.backgroundColor = UIColor(color: .purpleAB9BFF)
    }

    // MARK: Layout

    private func setupLayout() {
        heightAnchor == 40

        titleLabel.leftAnchor == leftAnchor + 16
        titleLabel.centerYAnchor == centerYAnchor + 1
        titleLabel.rightAnchor <= doneButton.leftAnchor - 16
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        doneButton.topAnchor == topAnchor + 4
        doneButton.rightAnchor == rightAnchor - 12
        doneButton.bottomAnchor == bottomAnchor - 4
        doneButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

}
