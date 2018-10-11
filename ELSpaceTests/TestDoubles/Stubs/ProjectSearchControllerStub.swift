@testable import ELSpace
import RxSwift

class ProjectSearchControllerStub: ProjectSearchControlling {

    let stubbedProjects = PublishSubject<[ProjectDTO]>()

    // MARK: ProjectSearchControlling

    var projects: Observable<[ProjectDTO]> {
        return stubbedProjects.asObservable()
    }

}
