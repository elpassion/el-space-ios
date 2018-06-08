import UIKit
import Anchorage

class ReportDetailsView: UIControl {

    init(title: String?, subtitle: String?) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        isUserInteractionEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("deinit details VIEW")
    }

    // MARK: - Subviews

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    private let titleLabel = SubviewsFactory.titleLabel
    private let subtitleLabel = SubviewsFactory.subtitleLabel

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
        static var titleLabel: UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Gotham-Medium", size: 13)
            label.textColor = UIColor(color: .grayB3B3B8)
            return label
        }

        static var subtitleLabel: UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Gotham-Book", size: 12)
            label.textColor = UIColor(color: .grayB3B3B8)
            return label
        }
    }

}
