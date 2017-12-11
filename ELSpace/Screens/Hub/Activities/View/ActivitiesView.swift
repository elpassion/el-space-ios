import UIKit

class ActivitiesView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subviews

    let stackView = SubviewsFactory.stackView

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    private let scrollView = SubviewsFactory.scrollView

    // MARK: - Layout

    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
        stackView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width)
            $0.top.left.right.equalTo(0)
            $0.bottom.lessThanOrEqualTo(0)
        }
    }

}

private extension ActivitiesView {

    struct SubviewsFactory {
        static var stackView: UIStackView {
            let stackView = UIStackView(frame: .zero)
            stackView.distribution = .fill
            stackView.axis = .vertical
            stackView.spacing = 0
            return stackView
        }

        static var scrollView: UIScrollView {
            let view = UIScrollView(frame: .zero)
            view.alwaysBounceVertical = true
            return view
        }
    }

}
