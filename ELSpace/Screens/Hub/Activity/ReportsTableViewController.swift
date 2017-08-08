import UIKit

class ReportsTableViewController: UITableViewController {

    var viewModels: [DailyReportViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.applayHubStyle()
    }

    init() {
        super.init(style: .plain)
        tableView.register(ReportCell.self, forCellReuseIdentifier: ReportCell.reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        return reportCell(tableView, indexPath: indexPath, viewModel: viewModel)
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Private

    func reportCell(_ tableView: UITableView, indexPath: IndexPath, viewModel: DailyReportViewModel) -> ReportCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReportCell.reuseIdentifier, for: indexPath) as? ReportCell else { fatalError() }
        viewModel.bind(to: cell).disposed(by: cell.reusabilityDisposeBag)
        return cell
    }

}
