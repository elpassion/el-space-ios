@testable import ELSpace

import RxSwift

class HubTokenServiceSpy: HubTokenServiceProtocol {

    var result: String?
    private(set) var googleTokenId: String?

    // MARK: - HubTokenServiceProtocol

    func getHubToken(googleTokenId: String) -> Observable<String> {
        self.googleTokenId = googleTokenId
        if result == nil { return Observable.error(NSError(domain: "fake_domain", code: 999, userInfo: nil)) }
        return Observable.just(result!)
    }

}
