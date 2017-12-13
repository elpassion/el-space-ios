import UIKit
import Anchorage

class ActivityTypeView: UIView {

    init() {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let imageView = Factory.imageView()
    let titleLabel = Factory.titleLabel()

    // MARK: - Privates

    private func addSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }

    private func setupLayout() {

    }

}

private extension ActivityTypeView {
    struct Factory {

        static func imageView() -> UIImageView {
            let imageView = UIImageView(frame: .zero)
            imageView.contentMode = .center
            return imageView
        }

        static func titleLabel() -> UILabel {
            let label = UILabel(frame: .zero)
            label.textAlignment = .center
            return label
        }

    }
}
