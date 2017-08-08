import Foundation

extension DateFormatter {

    static var shortDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter.warsawTimeZoneFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }

    static var dayFormatter: DateFormatter {
        let dateFormatter = DateFormatter.warsawTimeZoneFormatter
        dateFormatter.dateFormat = "d E"
        return dateFormatter
    }

    static var monthFormatter: DateFormatter {
        let dateFormatter = DateFormatter.warsawTimeZoneFormatter
        dateFormatter.locale = Locale(identifier: "pl")
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter
    }

    // MARK: - Private

    private static var warsawTimeZoneFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Warsaw")
        return dateFormatter
    }

}
