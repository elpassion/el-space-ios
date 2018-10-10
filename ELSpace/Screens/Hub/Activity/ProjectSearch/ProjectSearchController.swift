import RxSwift
import RxCocoa

protocol ProjectSearchControlling {
    var projects: Observable<[ProjectDTO]> { get }
}

class ProjectSearchController: ProjectSearchControlling {

    init(projectsService: ProjectsServiceProtocol) {
        self.projectsService = projectsService
    }

    // MARK: ProjectSearchControlling

    var projects: Observable<[ProjectDTO]> {
        return projectsService.getProjects()
    }

    // MARK: Privates

    private let projectsService: ProjectsServiceProtocol

}
