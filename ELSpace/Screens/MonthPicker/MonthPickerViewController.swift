import Anchorage
import UIKit

class MonthPickerViewController: UIViewController {

    init(raportDateProvider: RaportDateProviding) {
        self.raportDateProvider = raportDateProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    override func loadView() {
        view = MonthPickerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Privates

    private let raportDateProvider: RaportDateProviding

    private var monthPickerView: MonthPickerView! {
        return view as? MonthPickerView
    }

    private func configure() {
        monthPickerView.datePicker.minimumDate = raportDateProvider.firstRaportDate
        monthPickerView.datePicker.maximumDate = raportDateProvider.currentRaportDateRelay.value

    }

}
