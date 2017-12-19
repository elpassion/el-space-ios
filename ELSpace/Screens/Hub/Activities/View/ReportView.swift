import UIKit

class ReportView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
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
        addSubview(containerView)
        containerView.addSubview(dateLabel)
        containerView.addSubview(titleLabel)
        addSubview(reportDetailsContainer)
    }

    private let reportDetailsContainer = UIView(frame: .zero)
    private let containerView = UIView(frame: .zero)

    // MARK: Layout

    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.top.equalTo(19)
            $0.left.right.equalTo(0)
            $0.bottom.equalTo(reportDetailsContainer.snp.top).offset(-15)
        }
        dateLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(0)
            $0.left.equalTo(20)
            $0.right.lessThanOrEqualTo(titleLabel.snp.left).offset(5)
        }
        titleLabel.snp.makeConstraints {
            $0.right.lessThanOrEqualTo(0)
            $0.left.equalTo(80)
            $0.bottom.top.equalTo(0)
        }
        reportDetailsContainer.snp.makeConstraints {
            $0.left.equalTo(80)
            $0.right.equalTo(0)
            $0.bottom.equalTo(0).priority(.high)
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
            label.font = UIFont(name: "Helvetica", size: 16)
            label.textColor = UIColor(color: .greyB3B3B8)
            return label
        }
    }

}
