import UIKit

enum Color: String {
    case purpleCEC1FF = "CEC1FF"
    case purpleAB9BFF = "AB9BFF"
}

extension UIColor {
    convenience init!(color: Color) {
        self.init(hexString: color.rawValue)
    }
}
