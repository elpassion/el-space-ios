import UIKit
import RxSwift

class ChooserActivityTypesViewModel: ChooserActivityTypesViewModeling {

    init() {
        configureViewModels()
    }

    lazy var activityTypeViewModels: [ActivityTypeViewModeling] = [timeReportViewModel,
                                                                   vacationViewModel,
                                                                   dayOffViewModel,
                                                                   sickLeaveViewModel,
                                                                   conferenceViewModel]

    // MARK: - Private

    private let timeReportViewModel = ActivityTypeViewModel(type: .timeReport)
    private let vacationViewModel = ActivityTypeViewModel(type: .vacation)
    private let dayOffViewModel = ActivityTypeViewModel(type: .dayOff)
    private let sickLeaveViewModel = ActivityTypeViewModel(type: .sickLeave)
    private let conferenceViewModel = ActivityTypeViewModel(type: .conference)

    private let disposeBag = DisposeBag()
    private weak var lastSelectedViewModel: ActivityTypeViewModeling?

    private func configureViewModels() {
        activityTypeViewModels.forEach { viewModel in
            viewModel.isSelected.asObservable()
                .subscribe(onNext: { [weak self] _ in
                    if self?.lastSelectedViewModel !== viewModel {
                        self?.lastSelectedViewModel?.isSelected.onNext(false)
                        self?.lastSelectedViewModel = viewModel
                    }
                })
                .disposed(by: disposeBag)
        }
    }

}
