@testable import ELSpace
import RxSwift
import RxCocoa

class RaportDateProviderStub: RaportDateProviding {

    var currentRaportDate = BehaviorRelay<Date>(value: Date.init(timeIntervalSince1970: 0))
    var firstRaportDate = Date.distantPast
    var latestRaportDate = Date.distantFuture

}
