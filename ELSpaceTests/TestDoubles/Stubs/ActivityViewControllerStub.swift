@testable import ELSpace

import RxSwift

class ActivityViewControllerStub: UIViewController, ActivityViewControlling {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    let viewDidAppearSubject = PublishSubject<Void>()

    // MARK: - ActivityViewControlling

    var viewModels: [DailyReportViewModelProtocol] = []
    var navigationItemTitle: String?

    var viewDidAppear: Observable<Void> {
        return viewDidAppearSubject.asObservable()
    }

    var isLoading: AnyObserver<Bool> {
        return AnyObserver(eventHandler: { _ in })
    }

    var addActivity: Observable<NewActivityDTO> {
        return Observable.empty()
    }

    var updateActivity: Observable<NewActivityDTO> {
        return Observable.empty()
    }

    var deleteAction: Observable<Void> {
        return Observable.empty()
    }

}
