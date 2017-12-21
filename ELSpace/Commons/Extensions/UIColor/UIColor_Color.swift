import UIKit

enum Color: String {
    case purpleCEC1FF = "CEC1FF"
    case purpleAB9BFF = "AB9BFF"
    case black5F5A6A = "5F5A6A"
    case greyBCAEF8 = "BCAEF8"
    case purpleB3B3B8 = "B3B3B8"
    case redBA6767 = "BA6767"
}

extension UIColor {
    convenience init!(color: Color) {
        self.init(hexString: color.rawValue)
    }
}
