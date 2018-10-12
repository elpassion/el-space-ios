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
            .map {
                $0.reduce([]) { result, project in
                    result.contains(where: { $0.id == project.id }) ? result : result + [project]
                }
            }
    }

    // MARK: Privates

    private let projectsService: ProjectsServiceProtocol

}
