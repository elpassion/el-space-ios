import RxCocoa

protocol ProjectSearchViewModelProtocol {
    var selectedProjectId: Int? { get }
    var projects: Driver<[ProjectDTO]> { get }
}

class ProjectSearchViewModel: ProjectSearchViewModelProtocol {

    init(projectId: Int?) {
        self.selectedProjectId = projectId
    }

    let selectedProjectId: Int?

    var projects: Driver<[ProjectDTO]> {
        return .just([
            ProjectDTO.fakeProjectDto(name: "The Matrix", id: 1),
            ProjectDTO.fakeProjectDto(name: "Inception", id: 2),
            ProjectDTO.fakeProjectDto(name: "Die Hard Hotel", id: 3),
            ProjectDTO.fakeProjectDto(name: "Ein Projekt", id: 237),
            ProjectDTO.fakeProjectDto(name: "Ein Projekt 2", id: 5),
            ])
    }

}
