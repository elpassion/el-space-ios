import UIKit
import Anchorage

class ActivityView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView(_ view: UIView ) {
        let arrangedView = Factory.shadowedView(with: view)
        stackView.addArrangedSubview(arrangedView)
    }

    let scrollView = Factory.scrollView()

    // MARK: - Private

    private let stackView = Factory.stackView()

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    private func setupLayout() {
        scrollView.edgeAnchors == edgeAnchors

        stackView.edgeAnchors == scrollView.edgeAnchors + 16
        stackView.widthAnchor == scrollView.widthAnchor - 32
    }

}

private extension ActivityView {
    struct Factory {

        static func shadowedView(with contentView: UIView) -> UIView {
            let view = UIView(frame: .zero)
            view.addSubview(contentView)
            contentView.edgeAnchors == view.edgeAnchors + 8
            view.backgroundColor = .white
            view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            view.layer.shadowOpacity = 1
            view.layer.shadowRadius = 7
            view.layer.cornerRadius = 6
            return view
        }

        static func scrollView() -> UIScrollView {
            let scrollView = UIScrollView(frame: .zero)
            scrollView.keyboardDismissMode = .interactive
            scrollView.showsVerticalScrollIndicator = false
            return scrollView
        }

        static func stackView() -> UIStackView {
            let view = UIStackView(arrangedSubviews: [])
            view.axis = .vertical
            view.distribution = .fill
            view.spacing = 16
            return view
        }

    }
}
