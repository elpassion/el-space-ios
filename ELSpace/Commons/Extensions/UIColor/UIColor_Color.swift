import UIKit

enum Color: String {
    case purpleCEC1FF = "CEC1FF"
    case purpleAB9BFF = "AB9BFF"
    case black5F5A6A = "5F5A6A"
    case greyB3B3B8 = "B3B3B8"
    case purpleBCAEF8 = "BCAEF8"
    case purpleEAEAF5 = "EAEAF5"
}

extension UIColor {
    convenience init!(color: Color) {
        self.init(hexString: color.rawValue)
    }
}
