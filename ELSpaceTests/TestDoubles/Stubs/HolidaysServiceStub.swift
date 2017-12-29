@testable import ELSpace

import RxSwift

class HolidaysServiceStub: HolidaysServiceProtocol {

    var result: HolidaysDTO?

    // MARK: - HolidaysServiceProtocol

    func getHolidays() -> Observable<HolidaysDTO> {
        if let result = result {
            return Observable.just(result)
        }
        return Observable.empty()
    }

}
