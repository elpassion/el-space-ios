import Foundation

extension Date {

    func startOfMonth() -> Date {
        guard let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self))) else { return Date() }
        return startOfMonth
    }

    func endOfMonth() -> Date {
        guard let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()) else { return Date() }
        return endOfMonth
    }

}
