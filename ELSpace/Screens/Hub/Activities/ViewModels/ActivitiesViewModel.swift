import RxSwift
import SwiftDate

protocol ActivitiesViewModelProtocol {
    var dataSource: Observable<[DailyReportViewModelProtocol]> { get }
    var isLoading: Observable<Bool> { get }
    var month: String { get }
    func getData()
}

class ActivitiesViewModel: ActivitiesViewModelProtocol {

    init(activitiesController: ActivitiesControlling) {
        self.activitiesController = activitiesController
        setupBindings()
    }

    // MARK: - ActivitiesViewModelProtocol

    func getData() {
        activitiesController.getReports(from: startOfCurrentMonth, to: endOfCurrentMonth)
        activitiesController.getProjects()
    }

    var dataSource: Observable<[DailyReportViewModelProtocol]> {
        return viewModels.asObservable().ignoreWhen { $0.isEmpty }
    }

    var isLoading: Observable<Bool> {
        return activitiesController.isLoading
    }

    var month: String {
        return monthFormatter.string(from: Date())
    }

    // MARK: - Private

    private let activitiesController: ActivitiesControlling
    private let shortDateFormatter = DateFormatter.shortDateFormatter
    private let monthFormatter = DateFormatter.monthFormatter

    private let projects = Variable<[ProjectDTO]>([])
    private let reports = Variable<[ReportViewModelProtocol]>([])
    private let viewModels = Variable<[DailyReportViewModelProtocol]>([])

    private var days: [Date] {
        return Date.dates(between: Date().startOf(component: .month),
                          and: Date().endOf(component: .month),
                          increment: 1.day)
    }

    private var startOfCurrentMonth: String {
        let date = Date().startOf(component: .month)
        return shortDateFormatter.string(from: date)
    }

    private var endOfCurrentMonth: String {
        let date = Date().endOf(component: .month)
        return shortDateFormatter.string(from: date)
    }

    private func createViewModels() {
        let viewModels = days.map { date -> DailyReportViewModel in
            let reports = self.reports.value.filter { date.isInSameDayOf(date: $0.date) }
            let viewModel = DailyReportViewModel(date: date, reports: reports, projects: projects.value)
            return viewModel
        }
        setupSeparators(viewModels: viewModels)
        // TODO: - Setup corners
        self.viewModels.value = viewModels
    }

    private func setupSeparators(viewModels: [DailyReportViewModel]) {
        viewModels.forEach {
            if $0.dayType == .weekend {
                $0.isSeparatorHidden = true
            }
            let isLast = viewModels.last == $0
            if isLast == true {
                $0.isSeparatorHidden = true
            }
            if let nextIndex = viewModels.index(of: $0), isLast == false {
                let nextElement = viewModels[nextIndex + 1]
                if nextElement.dayType == .weekend && nextElement.reportsViewModel.isEmpty {
                    $0.isSeparatorHidden = true
                }
            }
        }
    }

    private func setupCornersRounding() {

    }

    // MARK: - Bindings

    private func setupBindings() {
        activitiesController.reports
            .map { $0.map { ReportViewModel(report: $0) } }
            .bind(to: reports)
            .disposed(by: disposeBag)

        activitiesController.projects
            .bind(to: projects)
            .disposed(by: disposeBag)

        activitiesController.didFinishFetch
            .subscribe(onNext: { [weak self] in
                self?.createViewModels()
            }).disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}

extension ActivitiesViewModelProtocol {

    var monthObservable: Observable<String> {
        return Observable.just(month)
    }

}
