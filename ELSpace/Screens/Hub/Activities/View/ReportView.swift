import UIKit

class ReportView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        roundCorners()
    }

    var areTopCornersRounded = false
    var areBottomCornersRounded = false

    var reportDetailsViews: [ReportDetailsView] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            reportDetailsViews.forEach { reportDetailsContainer.addSubview($0) }
            setupReportDetailsLayout()
        }
    }

    // MARK: - Subviews

    let dateLabel = SubviewsFactory.label
    let titleLabel = SubviewsFactory.label
    let rightStripeView = UIView(frame: .zero)
    let contentContainer = UIView(frame: .zero)

    private func addSubviews() {
        addSubview(contentContainer)
        contentContainer.addSubview(rightStripeView)
        contentContainer.addSubview(dateLabel)
        contentContainer.addSubview(titleLabel)
        contentContainer.addSubview(reportDetailsContainer)
    }

    private let reportDetailsContainer = UIView(frame: .zero)

    // MARK: - Layout

    private func setupLayout() {
        contentContainer.snp.makeConstraints {
            $0.top.bottom.equalTo(0)
            $0.right.equalTo(-20)
            $0.left.equalTo(20)
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(rightStripeView.snp.right).offset(76)
            $0.top.equalTo(17)
            $0.right.lessThanOrEqualTo(-10)
            $0.bottom.lessThanOrEqualTo(-17)
        }
        dateLabel.snp.makeConstraints {
            $0.left.equalTo(rightStripeView.snp.right).offset(17)
            $0.right.lessThanOrEqualTo(titleLabel.snp.left)
            $0.top.equalTo(17)
            $0.bottom.lessThanOrEqualTo(-17)
        }
        reportDetailsContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.left.equalTo(titleLabel.snp.left)
            $0.right.equalTo(0)
            $0.bottom.equalTo(0)
        }
        rightStripeView.snp.makeConstraints {
            $0.width.equalTo(3)
            $0.top.left.bottom.equalTo(0)
        }
    }

    private func setupReportDetailsLayout() {
        reportDetailsViews.enumerated().forEach { index, view in
            let isFirst = reportDetailsViews.first == view
            let isLast = reportDetailsViews.last == view
            view.snp.makeConstraints {
                if isFirst {
                    $0.top.equalTo(0)
                } else {
                    let previous = reportDetailsViews[index - 1]
                    $0.top.equalTo(previous.snp.bottom).offset(10)
                }
                $0.right.left.equalTo(0)
                if isLast { $0.bottom.equalTo(-19) }
            }
        }
    }

    // MARK: - Corners rounding

    private var roundedCorners: UIRectCorner {
        switch (areTopCornersRounded, areBottomCornersRounded) {
        case (true, true): return .allCorners
        case (true, false): return [.topRight, .topLeft]
        case (false, true): return [.bottomRight, .bottomLeft]
        case (false, false): return []
        }
    }

    private func roundCorners() {
        let path = UIBezierPath(roundedRect: contentContainer.bounds,
                                byRoundingCorners: roundedCorners,
                                cornerRadii: CGSize(width: 5, height: 5)).cgPath
        let maskLayer = CAShapeLayer()
        maskLayer.frame = contentContainer.bounds
        maskLayer.path = path
        contentContainer.layer.mask = maskLayer
    }

}

private extension ReportView {

    struct SubviewsFactory {
        static var label: UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(color: .black5F5A6A)
            return label
        }
    }

}
