import UIKit
import SnapKit

class ActivityViewController: UIViewController {

    init(reportsTableViewController: ReportsTableViewController) {
        self.reportsTableViewController = reportsTableViewController
        super.init(nibName: nil, bundle: nil)
        addChildViewController(reportsTableViewController)
        view.addSubview(reportsTableViewController.tableView)
        reportsTableViewController.tableView.snp.makeConstraints { $0.edges.equalTo(0) }
    }

    let reportsTableViewController: ReportsTableViewController

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Loading

    private(set) lazy var loadingIndicator: LoadingIndicator = {
        return LoadingIndicator(superView: self.view)
    }()

}
