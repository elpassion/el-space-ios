import UIKit
import RxSwift

protocol ChooserActivityTypesViewModeling {
    var activityTypeViewModels: [ActivityTypeViewModeling] { get }
}

class ChooserActivityTypesViewModel: ChooserActivityTypesViewModeling {

    init(report: ReportDTO) {
        self.report = report
        configureViewModels()
    }

    lazy var activityTypeViewModels: [ActivityTypeViewModeling] = [timeReportViewModel,
                                                                   vacationViewModel,
                                                                   dayOffViewModel,
                                                                   sickLeaveViewModel,
                                                                   conferenceViewModel]

    // MARK: - Private

    private let report: ReportDTO
    private let timeReportViewModel = ActivityTypeViewModel(type: .timeReport)
    private let vacationViewModel = ActivityTypeViewModel(type: .vacation)
    private let dayOffViewModel = ActivityTypeViewModel(type: .dayOff)
    private let sickLeaveViewModel = ActivityTypeViewModel(type: .sickLeave)
    private let conferenceViewModel = ActivityTypeViewModel(type: .conference)

    private let disposeBag = DisposeBag()

    private var lastSelectedViewModel: ActivityTypeViewModeling?

    private func configureViewModels() {
        activityTypeViewModels.forEach { viewModel in
            viewModel.isSelected.asObservable()
                .subscribe(onNext: { [weak self] _ in
                    if self?.lastSelectedViewModel !== viewModel {
                        self?.lastSelectedViewModel?.isSelected.accept(false)
                        self?.lastSelectedViewModel = viewModel
                    }
                })
                .disposed(by: disposeBag)
        }
        activityTypeViewModels[report.reportType].isSelected.accept(true)
    }

}
