import RxSwift

protocol ActivityViewModelProtocol {
    var addActivity: AnyObserver<NewActivityDTO> { get }
    var updateActivity: AnyObserver<NewActivityDTO> { get }
    var deleteAction: AnyObserver<Void> { get }
    var isLoading: Observable<Bool> { get }
    var dismiss: Observable<Void> { get }
}

class ActivityViewModel: ActivityViewModelProtocol {

    init(activityType: ActivityType,
         service: ActivityServiceProtocol) {
        self.activityType = activityType
        self.service = service
    }

    // MARK: ActivityViewModelProtocol

    var addActivity: AnyObserver<NewActivityDTO> {
        return AnyObserver(onNext: { [weak self] in self?.addActivity($0) })
    }

    var updateActivity: AnyObserver<NewActivityDTO> {
        return AnyObserver(onNext: { [weak self] in self?.updateActivity($0) })
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

    var error: Observable<Error> {
        return errorSubject.asObservable()
    }

    // MARK: Private

    private let activityType: ActivityType
    private let service: ActivityServiceProtocol
    private let dismissSubject = PublishSubject<Void>()
    private let errorSubject = PublishSubject<Error>()
    private let activityIndicator = ActivityIndicator()
    private let disposeBag = DisposeBag()

    private func addActivity(_ activity: NewActivityDTO) {
        service.addActivity(activity)
            .trackActivity(activityIndicator)
            .subscribe(onNext: { [weak self] in self?.dismissSubject.onNext(()) },
                       onError: { [weak self] in self?.errorSubject.onNext($0) })
            .disposed(by: disposeBag)
    }

    private func updateActivity(_ activity: NewActivityDTO) {
        guard case .report(let report) = activityType else { return }
        service.updateActivity(activity, forId: report.id)
            .trackActivity(activityIndicator)
            .subscribe(onNext: { [weak self] in self?.dismissSubject.onNext(()) },
                       onError: { [weak self] in self?.errorSubject.onNext($0) })
            .disposed(by: disposeBag)
    }

    private func deleteActivity() {
        guard case .report(let report) = activityType else { return }
        service.deleteActivity(report)
            .trackActivity(activityIndicator)
            .subscribe(onNext: { [weak self] in self?.dismissSubject.onNext(()) },
                       onError: { [weak self] in self?.errorSubject.onNext($0) })
            .disposed(by: disposeBag)
    }

}
