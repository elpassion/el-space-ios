import Anchorage
import UIKit

class ProjectSearchView: UIView {

    init() {
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: Subviewa

    let searchBar = UISearchBar(frame: .zero)
    let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: Privates

    private func setupLayout() {
        addSubview(searchBar)
        addSubview(tableView)

        searchBar.topAnchor == safeAreaLayoutGuide.topAnchor
        searchBar.horizontalAnchors == safeAreaLayoutGuide.horizontalAnchors

        tableView.horizontalAnchors == safeAreaLayoutGuide.horizontalAnchors
        tableView.topAnchor == searchBar.bottomAnchor
        tableView.bottomAnchor == safeAreaLayoutGuide.bottomAnchor
    }

}
