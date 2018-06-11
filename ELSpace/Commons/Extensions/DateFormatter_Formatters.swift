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
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter
    }

    static var activityFormatter: DateFormatter {
        let dateFormatter = DateFormatter.warsawTimeZoneFormatter
        dateFormatter.dateFormat = "E, d MMM yyyy"
        return dateFormatter
    }

    static var fullDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter.warsawTimeZoneFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }

    // MARK: - Private

    private static var warsawTimeZoneFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Warsaw")
        return dateFormatter
    }

}
