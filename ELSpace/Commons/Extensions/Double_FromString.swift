extension Double {

    init?(from string: String?) {
        guard let string = string, let double = Double(string) else { return nil }
        self = double
    }

}
