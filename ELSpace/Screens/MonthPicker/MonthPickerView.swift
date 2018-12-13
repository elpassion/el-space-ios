import Anchorage
import NTMonthYearPicker
import UIKit

class MonthPickerView: UIView {

    init() {
        super.init(frame: .zero)
        configureSubviews()
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    let datePicker = NTMonthYearPicker()

    // MARK: - Privates

    private let toolbar = UIToolbar(frame: .zero)

    private func configureSubviews() {
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(datePicker)
    }

    private func setupLayout() {
        datePicker.edgeAnchors == edgeAnchors
    }

}
