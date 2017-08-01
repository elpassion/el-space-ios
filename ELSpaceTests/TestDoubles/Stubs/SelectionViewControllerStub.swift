@testable import ELSpace

import RxSwift

class SelectionViewControllerStub: SelectionViewControlling {

    let openHubWithTokenSubject = PublishSubject<String>()
    let openDebateSubject = PublishSubject<Void>()

    // MARK: - SelectionViewControlling

    var openHubWithToken: Observable<String> {
        return openHubWithTokenSubject.asObservable()
    }

    var openDebate: Observable<Void> {
        return openDebateSubject.asObservable()
    }

}
