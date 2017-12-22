import RxSwift

protocol ActivityViewModelProtocol {
    var addAction: AnyObserver<Void> { get }
    var isLoading: Observable<Bool> { get }
    var dismiss: Observable<Void> { get }
}

class ActivityViewModel: ActivityViewModelProtocol {

    init(service: ActivitiesServiceProtocol) {
        self.service = service
    }

    // MARK: ActivityViewModelProtocol

    var addAction: AnyObserver<Void> {
        return AnyObserver(onNext: { [weak self] in self?.addActivity() })
    }

    var isLoading: Observable<Bool> {
        return isLoadingSubject.asObservable()
    }

    var dismiss: Observable<Void> {
        return dismissSubject.asObservable()
    }

    // MARK: Private

    private let service: ActivitiesServiceProtocol
    private let isLoadingSubject = PublishSubject<Bool>()
    private let dismissSubject = PublishSubject<Void>()
    private var addActivityDisposeBag: DisposeBag?

    private func addActivity() {
        let disposeBag = DisposeBag()
        addActivityDisposeBag = disposeBag
        let activity = NewActivityDTO( // TODO: data mocked up for now
            projectId: 294,
            userId: 40,
            value: 1,
            performedAt: "2017-12-22",
            comment: "EL SPACE TEST",
            reportType: 0
        )
        isLoadingSubject.onNext(true)
        service.addActivity(activity)
            .subscribe(onDisposed: { [weak self] in
                self?.isLoadingSubject.onNext(false)
                self?.dismissSubject.onNext(())
            })
            .disposed(by: disposeBag)
    }

}
