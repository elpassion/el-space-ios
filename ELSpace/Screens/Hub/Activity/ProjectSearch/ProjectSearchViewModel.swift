import RxSwift
import RxCocoa

protocol ProjectSearchViewModelProtocol {
    var selectedProjectId: Int? { get }
    var projects: Driver<[ProjectDTO]> { get }
    var searchText: AnyObserver<String> { get }
    var selectProject: AnyObserver<ProjectDTO> { get }
    var didSelectProject: Driver<ProjectDTO> { get }
}

class ProjectSearchViewModel: ProjectSearchViewModelProtocol {

    init(projectId: Int?,
         projectSearchController: ProjectSearchControlling) {
        self.selectedProjectId = projectId
        self.projectSearchController = projectSearchController
        fetchData()
    }

    let selectedProjectId: Int?

    var projects: Driver<[ProjectDTO]> {
        return projectsRelay.asDriver(onErrorDriveWith: .empty())
    }

    var searchText: AnyObserver<String> {
        return AnyObserver(onNext: { [weak self] in self?.searchTextString = $0 })
    }

    var selectProject: AnyObserver<ProjectDTO> {
        return selectedProjectRelay.asObserver()
    }

    var didSelectProject: Driver<ProjectDTO> {
        return selectedProjectRelay.asDriver(onErrorDriveWith: .never())
    }

    // MARK: Privates

    private let disposeBag = DisposeBag()
    private let projectSearchController: ProjectSearchControlling
    private let projectsRelay = PublishRelay<[ProjectDTO]>()
    private let selectedProjectRelay = PublishSubject<ProjectDTO>()

    private var allProjects: [ProjectDTO] = [] {
        didSet {
            projectsRelay.accept(allProjects)
        }
    }

    private var searchTextString: String? {
        didSet {
            if let searchTextString = searchTextString {
                projectsRelay.accept(allProjects.filter { $0.name.starts(with: searchTextString) })
            } else {
                projectsRelay.accept(allProjects)
            }
        }
    }

    private func fetchData() {
        projectSearchController.projects
            .subscribe(onNext: { [weak self] in self?.allProjects = $0 })
            .disposed(by: disposeBag)
    }

}
