import RxCocoa
import RxSwift
import UIKit

protocol ProjectSearchViewControlling {
    var disposeBag: DisposeBag { get }
    var projectRelay: BehaviorRelay<[ProjectDTO]> { get }
    var searchText: Observable<String> { get }
    var didSelectProject: Observable<ProjectDTO> { get }
    var selectedProjectIdObserver: AnyObserver<Int?> { get }
}

class ProjectSearchViewController: UIViewController, ProjectSearchViewControlling {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: View

    override func loadView() {
        view = ProjectSearchView()
    }

    var projectSearchView: ProjectSearchView! {
        return view as? ProjectSearchView
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureTableView()
        setupBindings()
    }

    // MARK: ProjectSearchViewControlling

    let disposeBag = DisposeBag()

    let projectRelay = BehaviorRelay<[ProjectDTO]>(value: [])

    var searchText: Observable<String> {
        return searchTextRelay.asObservable()
    }

    var didSelectProject: Observable<ProjectDTO> {
        return didSelectProjectRelay.asObservable()
    }

    var selectedProjectIdObserver: AnyObserver<Int?> {
        return AnyObserver(onNext: { [weak self] in self?.selectedProjectId = $0 })
    }

    // MARK: Privates

    private let searchTextRelay = PublishRelay<String>()
    private let didSelectProjectRelay = PublishRelay<ProjectDTO>()
    private var selectedProjectId: Int?

    private func setupNavBar() {
        navigationItem.titleView = NavBarItemsFactory.titleView()
    }

    private func configureTableView() {
        projectSearchView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    private func setupBindings() {
        projectRelay
            .bind(to: projectSearchView.tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { [weak self] (_, element, cell) in
                self?.bind(project: element, to: cell)
            }
            .disposed(by: disposeBag)

        projectSearchView.searchBar.rx.text
            .unwrap()
            .bind(to: searchTextRelay)
            .disposed(by: disposeBag)

        projectSearchView.tableView.rx
            .modelSelected(ProjectDTO.self)
            .bind(to: didSelectProjectRelay)
            .disposed(by: disposeBag)
    }

}

private extension ProjectSearchViewController {
    struct NavBarItemsFactory {
        static func titleView() -> UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Gotham-Book", size: 17)
            label.textColor = .white
            label.text = "Project"
            return label
        }
    }
}

private extension ProjectSearchViewController {
    private func bind(project: ProjectDTO, to cell: UITableViewCell) {
        cell.textLabel?.text = project.name
        cell.textLabel?.font = UIFont(name: "Gotham-Book", size: 16)
        if let selectedProject = selectedProjectId,
            selectedProject == project.id {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}
