@testable import ELSpace

import RxSwift

class ActivitiesViewModelSpy: ActivitiesViewModelProtocol {

    private(set) var didCallGetData = false

    var dataSourceSubject = PublishSubject<[DailyReportViewModelProtocol]>()
    var openReportSubject = PublishSubject<(report: ReportDTO, projects: [ProjectDTO])>()
    var errorSubject = PublishSubject<Error>()

    // MARK: - ActivityViewModelProtocol

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

    var openReport: Observable<(report: ReportDTO, projects: [ProjectDTO])> {
        return openReportSubject.asObservable()
    }

    var createReport: Observable<((date: Date, projects: [ProjectDTO]))> {
        return Observable.never()
    }

    var error: Observable<Error> {
        return errorSubject.asObservable()
    }

}
