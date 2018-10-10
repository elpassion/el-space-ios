import RxCocoa
import RxSwift
import UIKit

protocol ProjectSearchViewControllerAssembly {
    var viewModel: ProjectSearchViewModelProtocol { get }
}

protocol ProjectSearchViewControlling {
}

class ProjectSearchViewController: UIViewController, ProjectSearchViewControlling {

    init(viewModel: ProjectSearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: View

    override func loadView() {
        view = ProjectSearchView()
    }

    private var projectSearchView: ProjectSearchView! {
        return view as? ProjectSearchView
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureTableView()
        setupBindings()
    }

    // MARK: Privates

    let disposeBag = DisposeBag()
    let viewModel: ProjectSearchViewModelProtocol

    private func setupNavBar() {
        navigationItem.titleView = NavBarItemsFactory.titleView()
    }

    private func configureTableView() {
        projectSearchView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    private func setupBindings() {
        viewModel.projects
            .drive(projectSearchView.tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { [weak self] (_, element, cell) in
                self?.bind(project: element, to: cell)
            }
            .disposed(by: disposeBag)

        projectSearchView.searchBar.rx.text
            .unwrap()
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)

        projectSearchView.tableView.rx
            .modelSelected(ProjectDTO.self)
            .bind(to: viewModel.selectProject)
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
        if let selectedProject = viewModel.selectedProjectId,
            selectedProject == project.id {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}
