import RxSwift

class ActivityViewModel {

    init(activityController: ActivityControlling) {
        self.activityController = activityController
        setupBindings()
    }

    func getReports() {
        activityController.getReports(from: startOfCurrentMonth, to: endOfCurrentMonth)
    }

    // MARK: - Private

    private let activityController: ActivityControlling
    private let shortDateFormatter = DateFormatter.shortDateFormatter()

    private var startOfCurrentMonth: String {
        let date = Date().startOfMonth()
        return shortDateFormatter.string(from: date)
    }

    private var endOfCurrentMonth: String {
        let date = Date().endOfMonth()
        return shortDateFormatter.string(from: date)
    }

    // MARK: Bindings

    private func setupBindings() {
        activityController.reports
            .subscribe(onNext: { reports in
                print(reports)
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
