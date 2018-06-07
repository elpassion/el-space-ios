import RxSwift
import RxCocoa
import SwiftDate

protocol ActivitiesViewModelProtocol {
    var dataSource: Observable<[DailyReportViewModelProtocol]> { get }
    var isLoading: Observable<Bool> { get }
    var month: String { get }
    var openReport: Observable<(report: ReportDTO, projects: [ProjectDTO])> { get }
    var openActivity: Observable<[ReportDTO]> { get }
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

    var openReport: Observable<(report: ReportDTO, projects: [ProjectDTO])> {
        return openReportSubject.asObservable()
    }

    var openActivity: Observable<[ReportDTO]> {
        return openActivitySubject.asObservable()
    }

    // MARK: - Private

    private let activitiesController: ActivitiesControlling
    private let todayDate: Date
    private let monthFormatter = DateFormatter.monthFormatter
    private let shortDateFormatter = DateFormatter.shortDateFormatter

    private let projects = Variable<[ProjectDTO]>([])
    private let reports = Variable<[ReportDTO]>([])
    private let holidays = BehaviorRelay<[Int]>(value: [])
    private let viewModels = BehaviorRelay<[DailyReportViewModelProtocol]>(value: [])
    private let openReportSubject = PublishSubject<(report: ReportDTO, projects: [ProjectDTO])>()
    private let openActivitySubject = PublishSubject<[ReportDTO]>()

    private var days: [Date] {
        return Date.dates(between: todayDate.startOf(component: .month),
                          and: todayDate.endOf(component: .month),
                          increment: 1.day)
    }

    private func createViewModels() {
        let viewModels = days.map { date -> DailyReportViewModel in
            let reports = self.reports.value.filter {
                let reportDate = getDate(stringDate: $0.performedAt)
                return date.isInSameDayOf(date: reportDate)
            }
            let viewModel = DailyReportViewModel(date: date,
                                                 todayDate: todayDate,
                                                 reports: reports,
                                                 projects: projects.value,
                                                 isHoliday: holidays.value.contains(date.day))
            return viewModel
        }
        setupSeparators(viewModels: viewModels)
        setupCornersRounding(viewModels: viewModels)
        self.viewModels.accept(viewModels)
    }

    private func setupSeparators(viewModels: [DailyReportViewModel]) {
        viewModels.enumerated().forEach { index, viewModel in
            let isLast = viewModels.last == viewModel
            if isLast {
                viewModel.isSeparatorHidden = true
            } else {
                let nextElement = viewModels[viewModels.index(after: index)]
                viewModel.isSeparatorHidden = viewModel.isWorkDayOrHaveReports && !nextElement.isWorkDayOrHaveReports ||
                    !viewModel.isWorkDayOrHaveReports && nextElement.isWorkDayOrHaveReports
            }
        }
    }

    private func setupCornersRounding(viewModels: [DailyReportViewModel]) {
        viewModels.enumerated().forEach { index, viewModel in
            let isFirst = viewModels.first == viewModel
            let isLast = viewModels.last == viewModel
            if isFirst {
                viewModel.topCornersRounded = viewModel.isWorkDayOrHaveReports
            } else {
                let previousElement = viewModels[viewModels.index(before: index)]
                viewModel.topCornersRounded = viewModel.isWorkDayOrHaveReports && !previousElement.isWorkDayOrHaveReports
            }
            if isLast {
                viewModel.bottomCornersRounded = viewModel.isWorkDayOrHaveReports
            } else {
                let nextElement = viewModels[viewModels.index(after: index)]
                viewModel.bottomCornersRounded = viewModel.isWorkDayOrHaveReports && !nextElement.isWorkDayOrHaveReports
            }
        }
    }

    private func getDate(stringDate: String) -> Date {
        guard let date = shortDateFormatter.date(from: stringDate) else { fatalError("Wrong date format") }
        return date
    }

    // MARK: - Bindings

    private func setupBindings() {
        activitiesController.reports
            .bind(to: reports)
            .disposed(by: disposeBag)

        activitiesController.projects
            .bind(to: projects)
            .disposed(by: disposeBag)

        activitiesController.holidays
            .bind(to: holidays)
            .disposed(by: disposeBag)

        activitiesController.didFinishFetch
            .subscribe(onNext: { [weak self] in self?.createViewModels()})
            .disposed(by: disposeBag)

        viewModels.asObservable()
            .subscribe(onNext: { [weak self] in $0.forEach { self?.setupBindings(viewModel: $0) } })
            .disposed(by: disposeBag)
    }

    private func setupBindings(viewModel: DailyReportViewModelProtocol) {
        viewModel.reportsViewModel.forEach { viewModel in
            viewModel.action.asObservable()
                .map { [weak self] _ in (report: viewModel.report, projects: self?.projects.value ?? []) }
                .bind(to: self.openReportSubject)
                .disposed(by: self.disposeBag)
        }
//        viewModel.action.asObservable().debug()
//            .map { viewModel.reports }
//            .bind(to: openActivitySubject)
//            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}

extension ActivitiesViewModelProtocol {

    var monthObservable: Observable<String> {
        return Observable.just(month)
    }

}
