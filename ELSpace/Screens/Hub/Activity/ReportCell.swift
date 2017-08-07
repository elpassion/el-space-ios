import UIKit
import RxSwift

class ReportCell: UITableViewCell, RxReusable {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeReusabilityBag()
        view.dateLabel.text = nil
        view.titleLabel.text = nil
        view.reportDetailsViews = []
    }

    // MARK: - RxReuseable

    private(set) var reusabilityDisposeBag = DisposeBag()

    func disposeReusabilityBag() {
        reusabilityDisposeBag = DisposeBag()
    }

    // MARK: - Subviews

    let view = ReportView()

    private func addSubviews() {
        contentView.addSubview(view)
    }

    // MARK: - Layout

    private func setupLayout() {
        view.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }

}
