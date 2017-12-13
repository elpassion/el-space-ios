import UIKit

class ReportView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        backgroundColor = .clear
        rightStripeView.backgroundColor = .red
        contentContainer.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var reportDetailsViews: [ReportDetailsView] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            reportDetailsViews.forEach { reportDetailsContainer.addSubview($0) }
            setupReportDetailsLayout()
        }
    }

    // MARK: Subviews

    let dateLabel = SubviewsFactory.label
    let titleLabel = SubviewsFactory.label

    private func addSubviews() {
        addSubview(contentContainer)
        contentContainer.addSubview(rightStripeView)
        contentContainer.addSubview(dateLabel)
        contentContainer.addSubview(titleLabel)
        contentContainer.addSubview(reportDetailsContainer)
    }

    private let reportDetailsContainer = UIView(frame: .zero)
    private let contentContainer = UIView(frame: .zero)
    private let rightStripeView = UIView(frame: .zero)

    // MARK: Layout

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
        }
        dateLabel.snp.makeConstraints {
            $0.left.equalTo(rightStripeView.snp.right).offset(17)
            $0.right.lessThanOrEqualTo(titleLabel.snp.left).offset(-5)
            $0.top.equalTo(17)
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
