import RxSwift
import RxCocoa
import Foundation

protocol RaportDateProviding {
    var currentRaportDate: BehaviorRelay<Date> { get }
    var firstRaportDate: Date { get }
    var latestRaportDate: Date { get }
}

class RaportDateProvider: RaportDateProviding {

    init(monthFormatter: DateFormatter) {
        firstRaportDate = monthFormatter.date(from: "January 2010") ?? .distantPast
    }

    let currentRaportDate = BehaviorRelay(value: Date())
    
    let firstRaportDate: Date

    var latestRaportDate: Date {
        return Date()
    }

}
