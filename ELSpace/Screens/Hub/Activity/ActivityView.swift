import UIKit
import Anchorage

class ActivityView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView(_ view: UIView ) {
        let arrangedView = Factory.shadowedView(with: view)
        stackView.addArrangedSubview(arrangedView)
    }

    // MARK: - Private

    private let stackView = Factory.stackView()

    private func addSubviews() {
        addSubview(stackView)
    }

    private func setupLayout() {
        stackView.topAnchor == topAnchor + 16
        stackView.leadingAnchor == leadingAnchor + 16
        stackView.trailingAnchor == trailingAnchor - 16
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

        static func stackView() -> UIStackView {
            let view = UIStackView(arrangedSubviews: [])
            view.axis = .vertical
            view.distribution = .fill
            view.spacing = 16
            return view
        }

    }
}
