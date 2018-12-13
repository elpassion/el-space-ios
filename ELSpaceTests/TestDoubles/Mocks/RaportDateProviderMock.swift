@testable import ELSpace
import RxSwift
import RxCocoa

class RaportDateProviderMock: RaportDateProviding {

    var currentRaportDate = BehaviorRelay<Date>(value: Date.distantFuture)
    var firstRaportDate = Date.distantPast

}
