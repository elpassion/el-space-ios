import RxSwift

protocol ActivityViewModelProtocol {
    var addAction: AnyObserver<Void> { get }
    var deleteAction: AnyObserver<Void> { get }
    var isLoading: Observable<Bool> { get }
    var dismiss: Observable<Void> { get }
}

class ActivityViewModel: ActivityViewModelProtocol {

    init(report: ReportDTO?,
         service: ActivityServiceProtocol) {
        self.report = report
        self.service = service
    }

    // MARK: ActivityViewModelProtocol

    var addAction: AnyObserver<Void> {
        return AnyObserver(onNext: { [weak self] in self?.addActivity() })
    }

    var deleteAction: AnyObserver<Void> {
        return AnyObserver(onNext: { [weak self] in self?.deleteActivity() })
    }

    var isLoading: Observable<Bool> {
        return activityIndicator.asSharedSequence().asObservable()
    }

    var dismiss: Observable<Void> {
        return dismissSubject.asObservable()
    }

    // MARK: Private

    private let report: ReportDTO?
    private let service: ActivityServiceProtocol
    private let dismissSubject = PublishSubject<Void>()
    private let activityIndicator = ActivityIndicator()
    private let disposeBag = DisposeBag()

    private func addActivity() {
        let activity = NewActivityDTO( // TODO: data mocked up for now
            projectId: 294,
            userId: 40,
            value: 1,
            performedAt: "2017-12-22",
            comment: "EL SPACE TEST",
            reportType: 0
        )
        service.addActivity(activity)
            .trackActivity(activityIndicator)
            .subscribe(onDisposed: { [weak self] in self?.dismissSubject.onNext(()) })
            .disposed(by: disposeBag)
    }

    private func deleteActivity() {
        guard let report = report else { return }
        service.deleteActivity(report)
            .trackActivity(activityIndicator)
            .subscribe(onDisposed: { [weak self] in self?.dismissSubject.onNext(()) })
            .disposed(by: disposeBag)
    }

}
