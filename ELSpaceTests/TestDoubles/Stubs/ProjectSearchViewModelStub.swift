@testable import ELSpace
import RxSwift
import RxCocoa

class ProjectSearchViewModelStub: ProjectSearchViewModelProtocol {

    let stubbedProjects = PublishSubject<[ProjectDTO]>()
    var caugthSearchText: String?
    var caughtSelectProject: ProjectDTO?
    let stubbedDidSelectProject = PublishSubject<ProjectDTO>()

    // MARK: ProjectSearchViewModelProtocol

    var selectedProjectId: Int?

    var projects: Driver<[ProjectDTO]> {
        return stubbedProjects.asDriver(onErrorDriveWith: .empty())
    }

    var searchText: AnyObserver<String> {
        return AnyObserver(onNext: { self.caugthSearchText = $0 })
    }

    var selectProject: AnyObserver<ProjectDTO> {
        return AnyObserver(onNext: { self.caughtSelectProject = $0 })
    }

    var didSelectProject: Driver<ProjectDTO> {
        return stubbedDidSelectProject.asDriver(onErrorDriveWith: .empty())
    }

}
