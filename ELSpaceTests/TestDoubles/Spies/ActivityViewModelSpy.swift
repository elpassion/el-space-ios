@testable import ELSpace

import RxSwift

class ActivitiesViewModelSpy: ActivitiesViewModelProtocol {

    private(set) var didCallGetData = false

    var dataSourceSubject = PublishSubject<[DailyReportViewModelProtocol]>()
    var openActivitySubject = PublishSubject<DailyReportViewModel>()

    // MARK: - ActivityViewModelProtocol

    var openActivity: Observable<DailyReportViewModel> {
        return openActivitySubject.asObservable()
    }

    var dataSource: Observable<[DailyReportViewModelProtocol]> {
        return dataSourceSubject.asObservable()
    }

    var isLoading: Observable<Bool> {
        return Observable.empty()
    }

    var month: String {
        return ""
    }

    func getData() {
        didCallGetData = true
    }

}
