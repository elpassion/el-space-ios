import UIKit
import Anchorage

class ReportView: UIControl {

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

    let dateLabel = UILabel(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    let rightStripeView = UIView(frame: .zero)
    let contentContainer = UIControl(frame: .zero)
    let separatorView = SubviewsFactory.separatorView
    let addIconControl = SubviewsFactory.addIconControl

    private func addSubviews() {
        addSubview(contentContainer)
        contentContainer.addSubview(addIconControl)
        contentContainer.addSubview(rightStripeView)
        contentContainer.addSubview(dateLabel)
        contentContainer.addSubview(titleLabel)
        contentContainer.addSubview(reportDetailsContainer)
        contentContainer.addSubview(separatorView)
    }

    private let reportDetailsContainer = SubviewsFactory.reportDetailsContainer

    // MARK: - Layout
    private func setupLayout() {
        contentContainer.topAnchor == topAnchor
        contentContainer.bottomAnchor == bottomAnchor
        contentContainer.rightAnchor == rightAnchor - 20
        contentContainer.leftAnchor == leftAnchor + 20

        titleLabel.leftAnchor == rightStripeView.rightAnchor + 83
        titleLabel.topAnchor == contentContainer.topAnchor + 17
        titleLabel.rightAnchor <= addIconControl.leftAnchor - 10
        titleLabel.bottomAnchor <= contentContainer.bottomAnchor - 17

        dateLabel.leftAnchor == rightStripeView.rightAnchor + 17
        dateLabel.rightAnchor <= titleLabel.leftAnchor - 1
        dateLabel.topAnchor == contentContainer.topAnchor + 17
        dateLabel.bottomAnchor <= separatorView.topAnchor - 17

        reportDetailsContainer.topAnchor == titleLabel.bottomAnchor + 15
        reportDetailsContainer.leftAnchor == titleLabel.leftAnchor
        reportDetailsContainer.rightAnchor == contentContainer.rightAnchor
        reportDetailsContainer.bottomAnchor == contentContainer.bottomAnchor

        rightStripeView.widthAnchor == 3
        rightStripeView.topAnchor == contentContainer.topAnchor
        rightStripeView.leftAnchor == contentContainer.leftAnchor
        rightStripeView.bottomAnchor == contentContainer.bottomAnchor

        addIconControl.heightAnchor == 40
        addIconControl.widthAnchor == 40
        addIconControl.rightAnchor == contentContainer.rightAnchor - 10
        addIconControl.topAnchor == contentContainer.topAnchor + 7

        separatorView.heightAnchor == 0.5
        separatorView.leftAnchor == contentContainer.leftAnchor + 20
        separatorView.rightAnchor == contentContainer.rightAnchor - 20
        separatorView.bottomAnchor == contentContainer.bottomAnchor
    }

    private func setupReportDetailsLayout() {
        reportDetailsViews.enumerated().forEach { index, view in
            let isFirst = reportDetailsViews.first == view
            let isLast = reportDetailsViews.last == view
            if isFirst {
                view.topAnchor == reportDetailsContainer.topAnchor
            } else {
                let previous = reportDetailsViews[index - 1]
                view.topAnchor == previous.bottomAnchor + 10
            }
            view.rightAnchor == reportDetailsContainer.rightAnchor
            view.leftAnchor == reportDetailsContainer.leftAnchor
            if isLast {
                view.bottomAnchor == reportDetailsContainer.bottomAnchor - 19
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
        static var separatorView: UIView {
            let view = UIView(frame: .zero)
            view.backgroundColor = UIColor(color: .purpleEAEAF5)
            return view
        }

        static var reportDetailsContainer: UIView {
            let view = UIView(frame: .zero)
            view.isUserInteractionEnabled = true
            return view
        }

        static var addIconControl: UIControl {
            let addImageView = UIImageView(image: UIImage(named: "add_icon"))
            addImageView.contentMode = .center
            let control = UIControl(frame: .zero)
            control.addSubview(addImageView)
            addImageView.edgeAnchors == control.edgeAnchors
            return control
        }

    }

}
