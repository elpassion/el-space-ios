import Foundation

extension Double {

    init?(from string: String?) {
        guard let string = string else { return nil }
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        if let number = formatter.number(from: string) {
            self = number.doubleValue
        } else if let double = Double(string) {
            self = double
        } else {
            return nil
        }
    }

}
