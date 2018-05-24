import RxSwift
import RxCocoa
import SwiftDate

protocol ActivitiesViewModelProtocol {
    var dataSource: Observable<[DailyReportViewModelProtocol]> { get }
    var isLoading: Observable<Bool> { get }
    var month: String { get }
    var openActivity: Observable<DailyReportViewModel> { get }
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
        activitiesController.fetchData(for: todayDate)
    }

    var dataSource: Observable<[DailyReportViewModelProtocol]> {
        return viewModels.asObservable().ignoreWhen { $0.isEmpty }
    }

    var isLoading: Observable<Bool> {
        return activitiesController.isLoading
    }

    var month: String {
        return monthFormatter.string(from: todayDate)
    }

    var openActivity: Observable<DailyReportViewModel> {
        return openActivitySubject.asObservable()
    }

    // MARK: - Private

    private let activitiesController: ActivitiesControlling
    private let todayDate: Date
    private let monthFormatter = DateFormatter.monthFormatter

    private let projects = Variable<[ProjectDTO]>([])
    private let reports = Variable<[ReportViewModelProtocol]>([])
    private let holidays = BehaviorRelay<[Int]>(value: [])
    private let viewModels = Variable<[DailyReportViewModelProtocol]>([])
    private let openActivitySubject = PublishSubject<DailyReportViewModel>()

    private var days: [Date] {
        return Date.dates(between: todayDate.startOf(component: .month),
                          and: todayDate.endOf(component: .month),
                          increment: 1.day)
    }

    private func createViewModels() {
        let viewModels = days.map { date -> DailyReportViewModel in
            let reports = self.reports.value.filter { date.isInSameDayOf(date: $0.date) }
            let viewModel = DailyReportViewModel(date: date,
                                                 todayDate: todayDate,
                                                 reports: reports,
                                                 projects: projects.value,
                                                 isHoliday: holidays.value.contains(date.day))
            setupBindings(viewModel: viewModel)
            return viewModel
        }
        setupSeparators(viewModels: viewModels)
        setupCornersRounding(viewModels: viewModels)
        self.viewModels.value = viewModels
    }

    private func setupBindings(viewModel: DailyReportViewModel) {
        viewModel.didTapOnReport
            .map { [weak viewModel] in viewModel }
            .unwrap()
            .bind(to: openActivitySubject)
            .disposed(by: disposeBag)
    }

    private func setupSeparators(viewModels: [DailyReportViewModel]) {
        viewModels.enumerated().forEach { index, viewModel in
            let isLast = viewModels.last == viewModel
            if isLast {
                viewModel.isSeparatorHidden = true
            } else {
                let nextElement = viewModels[viewModels.index(after: index)]
                viewModel.isSeparatorHidden = (viewModel.dayType != .weekend && nextElement.isWeekendWithoutReports) ||
                    (viewModel.isWeekendWithoutReports && nextElement.dayType != .weekend)
            }
        }
    }

    private func setupCornersRounding(viewModels: [DailyReportViewModel]) {
        viewModels.enumerated().forEach { index, viewModel in
            let isFirst = viewModels.first == viewModel
            let isLast = viewModels.last == viewModel
            if isFirst {
                viewModel.topCornersRounded = viewModel.dayType != .weekend || viewModel.hasReports
            } else {
                let previousElement = viewModels[viewModels.index(before: index)]
                viewModel.topCornersRounded = viewModel.dayType != .weekend &&
                    previousElement.dayType == .weekend &&
                    !previousElement.hasReports
            }
            if isLast {
                viewModel.bottomCornersRounded = viewModel.dayType != .weekend || viewModel.hasReports
            } else {
                let nextElement = viewModels[viewModels.index(after: index)]
                viewModel.bottomCornersRounded = viewModel.dayType != .weekend &&
                    nextElement.dayType == .weekend &&
                    !nextElement.hasReports
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

        activitiesController.holidays
            .bind(to: holidays)
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
