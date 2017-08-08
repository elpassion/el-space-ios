import Foundation

extension DateFormatter {

    static func shortDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter.warsawTimeZoneFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }

    static func dayFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter.warsawTimeZoneFormatter
        dateFormatter.dateFormat = "d E"
        return dateFormatter
    }

    // MARK: - Private

    private static var warsawTimeZoneFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Warsaw")
        return dateFormatter
    }

}
