@testable import ELSpace

import RxSwift

class ProjectsServiceStub: ProjectsServiceProtocol {

    var result: [ProjectDTO]!

    // MARK: - ProjectsServiceProtocol

    func getProjects() -> Observable<[ProjectDTO]> {
        return result == nil ? Observable.empty() : Observable.just(result!)
    }

}
