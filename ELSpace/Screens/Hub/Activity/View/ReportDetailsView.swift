import UIKit
import SnapKit

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
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalTo(0)
            $0.right.equalTo(0)
            $0.bottom.equalTo(subtitleLabel.snp.top).offset(-5)
        }
        subtitleLabel.snp.makeConstraints {
            $0.left.bottom.right.equalTo(0)
        }
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
