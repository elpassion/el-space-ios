import RxSwift
import RxCocoa
import SwiftDate

protocol ActivitiesViewModelProtocol {
    var dataSource: Observable<[DailyReportViewModelProtocol]> { get }
    var isLoading: Observable<Bool> { get }
    var month: Observable<String> { get }
    var openReport: Observable<(report: ReportDTO, projects: [ProjectDTO])> { get }
    var createReport: Observable<((date: Date, projects: [ProjectDTO]))> { get }
    var error: Observable<Error> { get }
    func getData()
}

class ActivitiesViewModel: ActivitiesViewModelProtocol {

    init(activitiesController: ActivitiesControlling,
         dateFormatters: ActivitiesDateFormatters,
         raportDateProvider: RaportDateProviding) {
        self.activitiesController = activitiesController
        self.dateFormatters = dateFormatters
        self.raportDateProvider = raportDateProvider
        setupBindings()
    }

    // MARK: - ActivitiesViewModelProtocol

    func getData() {
        activitiesController.fetchData(for: raportDateProvider.currentRaportDate.value)
    }

    var dataSource: Observable<[DailyReportViewModelProtocol]> {
        return viewModels.asObservable().ignoreWhen { $0.isEmpty }
    }

    var isLoading: Observable<Bool> {
        return activitiesController.isLoading
    }

    var month: Observable<String> {
        return raportDateProvider.currentRaportDate
            .map { [dateFormatters] date in
                dateFormatters.monthFormatter.string(from: date)
            }
    }

    var openReport: Observable<(report: ReportDTO, projects: [ProjectDTO])> {
        return openReportRelay.asObservable()
    }

    var createReport: Observable<((date: Date, projects: [ProjectDTO]))> {
        return createReportRelay.asObservable()
    }

    var error: Observable<Error> {
        return activitiesController.error
    }

    // MARK: - Private

    private let activitiesController: ActivitiesControlling
    private let dateFormatters: ActivitiesDateFormatters
    private let raportDateProvider: RaportDateProviding

    private let projects = BehaviorRelay<[ProjectDTO]>(value: [])
    private let reports = BehaviorRelay<[ReportDTO]>(value: [])
    private let holidays = BehaviorRelay<[Int]>(value: [])
    private let viewModels = BehaviorRelay<[DailyReportViewModelProtocol]>(value: [])
    private let openReportRelay = PublishRelay<(report: ReportDTO, projects: [ProjectDTO])>()
    private let createReportRelay = PublishRelay<(date: Date, projects: [ProjectDTO])>()

    private var days: [Date] {
        return Date.dates(between: raportDateProvider.currentRaportDate.value.startOf(component: .month),
                          and: raportDateProvider.currentRaportDate.value.endOf(component: .month),
                          increment: 1.day)
    }

    private func createViewModels() {
        let viewModels = days.map { date -> DailyReportViewModel in
            let reports = self.reports.value.filter {
                let reportDate = getDate(stringDate: $0.performedAt)
                return date.isInSameDayOf(date: reportDate)
            }
            let viewModel = DailyReportViewModel(date: date,
                                                 todayDate: raportDateProvider.currentRaportDate.value,
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
        guard let date = dateFormatters.shortDateFormatter.date(from: stringDate) else { fatalError("Wrong date format") }
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
            .subscribe(onNext: { [weak self] in self?.createViewModels() })
            .disposed(by: disposeBag)

        viewModels.asObservable()
            .subscribe(onNext: { [weak self] in $0.forEach { self?.setupBindings(viewModel: $0) } })
            .disposed(by: disposeBag)

        raportDateProvider.currentRaportDate
            .skip(1)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in self?.getData() })
            .disposed(by: disposeBag)
    }

    private func setupBindings(viewModel: DailyReportViewModelProtocol) {
        viewModel.reportsViewModel.forEach { viewModel in
            viewModel.action
                .map { [weak self] _ in (report: viewModel.report, projects: self?.projects.value ?? []) }
                .bind(to: self.openReportRelay)
                .disposed(by: self.disposeBag)
        }
        viewModel.action
            .map { viewModel.reports }
            .filter { reports -> Bool in
                guard reports.count == 1 else { return false }
                guard let firstReport = reports.first, let reportType = ReportType(rawValue: firstReport.reportType) else { return false }
                return reportType.isWholeDayActivity
            }
            .map { (report: $0[0], projects: []) }
            .bind(to: openReportRelay)
            .disposed(by: viewModel.disposeBag)

        viewModel.addReportAction
            .map { [weak self] in (date: viewModel.date, projects: self?.projects.value ?? []) }
            .bind(to: createReportRelay)
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}

extension ReportType {

    var isWholeDayActivity: Bool {
        return self == .unpaidDayOff || self == .sickLeave || self == .conference
    }

}
