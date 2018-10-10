import RxCocoa

protocol ProjectSearchViewModelProtocol {
    var selectedProjectId: Int? { get }
    var projects: Driver<[ProjectDTO]> { get }
}

class ProjectSearchViewModel: ProjectSearchViewModelProtocol {

    init(projectId: Int?,
         projectSearchController: ProjectSearchControlling) {
        self.selectedProjectId = projectId
        self.projectSearchController = projectSearchController
    }

    let selectedProjectId: Int?

    var projects: Driver<[ProjectDTO]> {
        return projectSearchController.reports.asDriver(onErrorDriveWith: .empty())
    }

    // MARK: Privates

    private let projectSearchController: ProjectSearchControlling

}
