@testable import ELSpace

import RxSwift

class HolidaysServiceStub: HolidaysServiceProtocol {

    var result: HolidaysDTO?
    private(set) var caughtMonth: Int?
    private(set) var caughtYear: Int?

    // MARK: - HolidaysServiceProtocol

    func getHolidays(month: Int, year: Int) -> Observable<HolidaysDTO> {
        caughtMonth = month
        caughtYear = year
        if let result = result {
            return Observable.just(result)
        }
        return Observable.empty()
    }

}
