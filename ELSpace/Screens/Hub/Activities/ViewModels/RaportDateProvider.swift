import RxSwift
import RxCocoa
import Foundation

protocol RaportDateProviding {
    var currentRaportDateRelay: BehaviorRelay<Date> { get }
    var firstRaportDate: Date { get }
}

class RaportDateProvider: RaportDateProviding {

    init(monthFormatter: DateFormatter) {
        firstRaportDate = monthFormatter.date(from: "January 2010") ?? Date.distantPast
    }

    let currentRaportDateRelay = BehaviorRelay(value: Date())
    let firstRaportDate: Date

}
