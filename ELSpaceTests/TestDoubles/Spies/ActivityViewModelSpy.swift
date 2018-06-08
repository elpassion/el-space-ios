@testable import ELSpace

import RxSwift

class ActivitiesViewModelSpy: ActivitiesViewModelProtocol {

    private(set) var didCallGetData = false

    var dataSourceSubject = PublishSubject<[DailyReportViewModelProtocol]>()
    var openReportSubject = PublishSubject<(report: ReportDTO, projects: [ProjectDTO])>()

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

}
