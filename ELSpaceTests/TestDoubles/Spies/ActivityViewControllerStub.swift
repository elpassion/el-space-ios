@testable import ELSpace

import RxSwift

class ActivityViewControllerStub: ActivityViewControlling {

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
