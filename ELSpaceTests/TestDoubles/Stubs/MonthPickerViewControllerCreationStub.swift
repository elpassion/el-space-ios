@testable import ELSpace
import UIKit

class MonthPickerViewControllerCreationStub: MonthPickerViewControllerCreation {

    func monthPicker() -> UIViewController & MonthPickerViewControlling {
        return MonthPickerViewControllerStub()
    }

}
