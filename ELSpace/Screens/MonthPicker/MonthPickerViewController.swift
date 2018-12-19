import RxCocoa
import RxSwift
import NTMonthYearPicker
import UIKit

protocol MonthPickerViewControlling {
    var dismiss: Driver<Void> { get }
}

class MonthPickerViewController: UIViewController, MonthPickerViewControlling {

    init(raportDateProvider: RaportDateProviding) {
        self.raportDateProvider = raportDateProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    override func loadView() {
        view = BottomMenuView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        setupBindings()
    }

    // MARK: - MonthPickerViewControlling

    var dismiss: Driver<Void> {
        return dismissRelay.asDriver(onErrorDriveWith: .never())
    }

    // MARK: - Privates

    private let raportDateProvider: RaportDateProviding
    private let dismissRelay = PublishRelay<Void>()
    private let monthPicker = NTMonthYearPicker()
    private let disposeBag = DisposeBag()

    private var bottomMenuView: BottomMenuView! {
        return view as? BottomMenuView
    }

    private func configureSubviews() {
        bottomMenuView.headerView.title = "Change month"
        bottomMenuView.headerView.doneButtonTitle = "Apply"
        bottomMenuView.items = [monthPicker]
        monthPicker.date = raportDateProvider.currentRaportDate.value
        monthPicker.minimumDate = raportDateProvider.firstRaportDate
        monthPicker.maximumDate = raportDateProvider.latestRaportDate
    }

    private func setupBindings() {
        bottomMenuView.backgroundTap
            .bind(to: dismissRelay)
            .disposed(by: disposeBag)

        bottomMenuView.headerView.doneButtonTap
            .subscribe(onNext: { [weak self] in self?.doneAction() })
            .disposed(by: disposeBag)
    }

    private func doneAction() {
        raportDateProvider.currentRaportDate.accept(monthPicker.date)
        dismissRelay.accept(())
    }

}
