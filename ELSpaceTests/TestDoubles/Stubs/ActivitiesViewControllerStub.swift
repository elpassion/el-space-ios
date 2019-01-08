@testable import ELSpace
import RxCocoa
import RxSwift

class ActivitiesViewControllerStub: UIViewController, ActivitiesViewControlling {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    private(set) var caughtError: Error?
    let viewDidAppearSubject = PublishSubject<Void>()
    let changeMonthSubject = PublishSubject<Void>()
    let addActivitySubject = PublishSubject<Void>()

    // MARK: - ActivityViewControlling

    var viewModels: [DailyReportViewModelProtocol] = []
    var navigationItemTitle: String?

    var changeMonth: Driver<Void> {
        return changeMonthSubject.asDriver(onErrorDriveWith: .never())
    }

    var viewDidAppear: Observable<Void> {
        return viewDidAppearSubject.asObservable()
    }

    var isLoading: AnyObserver<Bool> {
        return AnyObserver(eventHandler: { _ in })
    }

    var addActivity: Observable<Void> {
        return addActivitySubject.asObservable()
    }

    var error: AnyObserver<Error> {
        return AnyObserver(onNext: { [weak self] in self?.caughtError = $0 })
    }

}
