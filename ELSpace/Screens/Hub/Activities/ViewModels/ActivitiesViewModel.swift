import RxSwift
import SwiftDate

protocol ActivitiesViewModelProtocol {
    var dataSource: Observable<[DailyReportViewModelProtocol]> { get }
    var isLoading: Observable<Bool> { get }
    var month: String { get }
    func getData()
}

class ActivitiesViewModel: ActivitiesViewModelProtocol {

    init(activitiesController: ActivitiesControlling, todayDate: Date) {
        self.activitiesController = activitiesController
        self.todayDate = todayDate
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
    private let todayDate: Date
    private let shortDateFormatter = DateFormatter.shortDateFormatter
    private let monthFormatter = DateFormatter.monthFormatter

    private let projects = Variable<[ProjectDTO]>([])
    private let reports = Variable<[ReportViewModelProtocol]>([])
    private let viewModels = Variable<[DailyReportViewModelProtocol]>([])

    private var days: [Date] {
        return Date.dates(between: todayDate.startOf(component: .month),
                          and: todayDate.endOf(component: .month),
                          increment: 1.day)
    }

    private var startOfCurrentMonth: String {
        let date = todayDate.startOf(component: .month)
        return shortDateFormatter.string(from: date)
    }

    private var endOfCurrentMonth: String {
        let date = todayDate.endOf(component: .month)
        return shortDateFormatter.string(from: date)
    }

    private func createViewModels() {
        let viewModels = days.map { date -> DailyReportViewModel in
            let reports = self.reports.value.filter { date.isInSameDayOf(date: $0.date) }
            let viewModel = DailyReportViewModel(date: date,
                                                 todayDate: todayDate,
                                                 reports: reports,
                                                 projects: projects.value)
            return viewModel
        }
        setupSeparators(viewModels: viewModels)
        setupCornersRounding(viewModels: viewModels)
        self.viewModels.value = viewModels
    }

    private func setupSeparators(viewModels: [DailyReportViewModel]) {
        viewModels.enumerated().forEach { index, viewModel in
            let isLast = viewModels.last == viewModel
            if isLast {
                viewModel.isSeparatorHidden = true
            } else {
                let nextElement = viewModels[viewModels.index(after: index)]
                if viewModel.dayType != .weekend && nextElement.dayType == .weekend && nextElement.reportsViewModel.isEmpty {
                    viewModel.isSeparatorHidden = true
                }
                if viewModel.dayType == .weekend && nextElement.dayType != .weekend {
                    viewModel.isSeparatorHidden = true
                }
            }
        }
    }

    private func setupCornersRounding(viewModels: [DailyReportViewModel]) {
        viewModels.enumerated().forEach { index, viewModel in
            let isFirst = viewModels.first == viewModel
            let isLast = viewModels.last == viewModel
            if isFirst == false {
                let previousElement = viewModels[viewModels.index(before: index)]
                if previousElement.dayType == .weekend && previousElement.reportsViewModel.isEmpty {
                    viewModel.topCornersRounded = true
                }
            } else {
                viewModel.topCornersRounded = true
            }
            if isLast == false {
                let nextElement = viewModels[viewModels.index(after: index)]
                if nextElement.dayType == .weekend && nextElement.reportsViewModel.isEmpty {
                    viewModel.bottomCornersRounded = true
                }
            } else {
                viewModel.bottomCornersRounded = true
            }
        }
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
