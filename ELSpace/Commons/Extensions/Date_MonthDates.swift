import Foundation
import SwiftDate

extension Date {

    func startOfMonth() -> Date {
        return Date().startOf(component: .month) + 1.day
    }

    func endOfMonth() -> Date {
        return Date().endOf(component: .month)
    }

}
