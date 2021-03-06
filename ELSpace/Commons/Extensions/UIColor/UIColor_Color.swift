import UIKit

enum Color: String {
    case purpleCEC1FF = "CEC1FF"
    case purpleAB9BFF = "AB9BFF"
    case black5F5A6A = "5F5A6A"
    case purpleBCAEF8 = "BCAEF8"
    case purpleEAEAF5 = "EAEAF5"
    case grayB3B3B8 = "B3B3B8"
    case grayF8F8FA = "F8F8FA"
    case green92ECB4 = "92ECB4"
    case green4CC359 = "4CC359"
    case grayE4E4E4 = "E4E4E4"
    case blue17EAD9 = "17EAD9"
    case blue7177EA = "7177EA"
    case blue1BCEDF = "1BCEDF"
    case blue3BB2B8 = "3BB2B8"
    case purple622774 = "622774"
    case purple5B247A = "5B247A"
    case pinkF02FC2 = "F02FC2"
    case redEF5350 = "EF5350"
    case redBA6767 = "BA6767"
}

extension UIColor {
    convenience init!(color: Color) {
        self.init(hexString: color.rawValue)
    }
}
