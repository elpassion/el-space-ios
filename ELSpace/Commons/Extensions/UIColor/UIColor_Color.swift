import UIKit

enum Color: String {
    case purpleCEC1FF = "CEC1FF"
    case purpleAB9BFF = "AB9BFF"
    case black5F5A6A = "5F5A6A"
    case grayB3B3B8 = "B3B3B8"
    case grayF8F8FA = "F8F8FA"
    case green92ECB4 = "92ECB4"
    case brownBA6767 = "BA6767"
    case grayE4E4E4 = "E4E4E4"
}

extension UIColor {
    convenience init!(color: Color) {
        self.init(hexString: color.rawValue)
    }
}
