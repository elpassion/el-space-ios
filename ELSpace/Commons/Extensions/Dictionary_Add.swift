extension Dictionary {
    mutating func add(dict: Dictionary) {
        for (key, value) in dict {
            self.updateValue(value, forKey: key)
        }
    }
}
