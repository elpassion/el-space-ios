@testable import ELSpace
import UIKit
import RxCocoa
import RxSwift

class MonthPickerViewControllerStub: UIViewController, MonthPickerViewControlling {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: - MonthPickerViewControlling

    var dismiss: Driver<Void> {
        return dismissRelay.asDriver(onErrorDriveWith: .never())
    }

    // MARK: -

    let dismissRelay = PublishRelay<Void>()

}
