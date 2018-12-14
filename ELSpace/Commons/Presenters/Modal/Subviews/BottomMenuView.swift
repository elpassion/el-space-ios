import UIKit
import Anchorage
import RxSwift
import RxCocoa

class BottomMenuView: UIView {

    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    var items: [UIControl] = [] {
        didSet {
            oldValue.forEach {
                stackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
            items.forEach {
                stackView.addArrangedSubview($0)
            }
        }
    }

    var backgroundTap: ControlEvent<Void> {
        return backgroundView.rx.controlEvent(.touchUpInside)
    }

    // MARK: Subviews

    let headerView = BottomMenuHeaderView()

    let backgroundView = UIControl()
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView(arrangedSubviews: [])

    private func setupSubviews() {
        addSubview(backgroundView)
        backgroundView.backgroundColor = .clear
        addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.addSubview(headerView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
    }

    // MARK: Layout

    override func safeAreaInsetsDidChange() {
        scrollViewHeightConstraint?.constant = safeAreaBottomInset
    }

    private var scrollViewHeightConstraint: NSLayoutConstraint?

    private func setupLayout() {
        backgroundView.edgeAnchors == edgeAnchors

        contentView.leftAnchor == leftAnchor
        contentView.rightAnchor == rightAnchor
        contentView.bottomAnchor == bottomAnchor

        headerView.topAnchor == contentView.topAnchor
        headerView.leftAnchor == contentView.leftAnchor
        headerView.rightAnchor == contentView.rightAnchor

        scrollView.heightAnchor <= 240
        scrollViewHeightConstraint = scrollView.heightAnchor == stackView.heightAnchor + safeAreaBottomInset ~ .low
        scrollView.topAnchor == headerView.bottomAnchor
        scrollView.leftAnchor == contentView.leftAnchor
        scrollView.rightAnchor == contentView.rightAnchor
        scrollView.bottomAnchor == contentView.bottomAnchor

        stackView.edgeAnchors == scrollView.edgeAnchors
        stackView.widthAnchor == scrollView.widthAnchor
    }

    private var safeAreaBottomInset: CGFloat {
        if #available(iOS 11.0, *) {
            return safeAreaInsets.bottom
        } else {
            return 0
        }
    }

}
