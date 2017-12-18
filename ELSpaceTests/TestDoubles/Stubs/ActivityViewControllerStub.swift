@testable import ELSpace

import RxSwift

class ActivitiesViewControllerStub: UIViewController, ActivitiesViewControlling {

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

}
