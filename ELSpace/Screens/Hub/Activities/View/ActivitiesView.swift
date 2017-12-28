import UIKit
import Anchorage

class ActivitiesView: UIView {

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(color: .grayF8F8FA)
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
        scrollView.edgeAnchors == edgeAnchors

        stackView.widthAnchor == scrollView.widthAnchor
        stackView.topAnchor == scrollView.topAnchor + 20
        stackView.bottomAnchor == scrollView.bottomAnchor - 20
        stackView.horizontalAnchors == scrollView.horizontalAnchors
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
