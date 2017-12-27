import UIKit
import Anchorage

class ReportDetailsView: UIView {

    init(title: String?, subtitle: String?) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subviews

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    private let titleLabel = SubviewsFactory.label(size: 13)
    private let subtitleLabel = SubviewsFactory.label(size: 12)

    // MARK: - Layout

    private func setupLayout() {
        titleLabel.topAnchor == topAnchor
        titleLabel.leftAnchor == leftAnchor
        titleLabel.rightAnchor <= rightAnchor - 10
        titleLabel.bottomAnchor == subtitleLabel.topAnchor - 5

        subtitleLabel.leftAnchor == leftAnchor
        subtitleLabel.bottomAnchor == bottomAnchor
        subtitleLabel.rightAnchor <= rightAnchor - 10
    }

}

private extension ReportDetailsView {

    struct SubviewsFactory {
        static func label(size: CGFloat) -> UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Helvetica", size: size)
            label.textColor = UIColor(color: .grayB3B3B8)
            return label
        }
    }

}
