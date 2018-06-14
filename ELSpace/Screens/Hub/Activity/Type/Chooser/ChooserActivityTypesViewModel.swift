import UIKit
import RxSwift

protocol ChooserActivityTypesViewModeling {
    var activityTypeViewModels: [ActivityTypeViewModeling] { get }
}

class ChooserActivityTypesViewModel: ChooserActivityTypesViewModeling {

    init(activityType: ActivityType) {
        self.activityType = activityType
        var isUserInteractionEnabled = false
        switch activityType {
        case .report(_): isUserInteractionEnabled = false
        case .new(_): isUserInteractionEnabled = true
        }
        timeReportViewModel = ActivityTypeViewModel(type: .normal, isUserInteractionEnabled: isUserInteractionEnabled)
        vacationViewModel = ActivityTypeViewModel(type: .paidVacations, isUserInteractionEnabled: isUserInteractionEnabled)
        dayOffViewModel = ActivityTypeViewModel(type: .unpaidDayOff, isUserInteractionEnabled: isUserInteractionEnabled)
        sickLeaveViewModel = ActivityTypeViewModel(type: .sickLeave, isUserInteractionEnabled: isUserInteractionEnabled)
        conferenceViewModel = ActivityTypeViewModel(type: .conference, isUserInteractionEnabled: isUserInteractionEnabled)
        configureViewModels()
    }

    lazy var activityTypeViewModels: [ActivityTypeViewModeling] = [timeReportViewModel,
                                                                   vacationViewModel,
                                                                   dayOffViewModel,
                                                                   sickLeaveViewModel,
                                                                   conferenceViewModel]

    // MARK: - Private

    private let activityType: ActivityType
    private let timeReportViewModel: ActivityTypeViewModel
    private let vacationViewModel: ActivityTypeViewModel
    private let dayOffViewModel: ActivityTypeViewModel
    private let sickLeaveViewModel: ActivityTypeViewModel
    private let conferenceViewModel: ActivityTypeViewModel

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
        if case .report(let report) = activityType {
            activityTypeViewModels[report.reportType].isSelected.accept(true)
        } else if case .new(_) = activityType {
            activityTypeViewModels.first?.isSelected.accept(true)
        }
    }

}
