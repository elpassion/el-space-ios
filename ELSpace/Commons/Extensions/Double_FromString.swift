import Foundation

extension Double {

    init?(from string: String?) {
        guard let string = string else { return nil }
        if let double = Double(fromCommaSeparatedString: string) {
            self = double
        } else if let double = Double(string) {
            self = double
        } else {
            return nil
        }
    }

    private init?(fromCommaSeparatedString string: String) {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        if let number = formatter.number(from: string) {
            self = number.doubleValue
        } else {
            return nil
        }
    }

}
