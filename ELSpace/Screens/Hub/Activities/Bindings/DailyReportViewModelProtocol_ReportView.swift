import RxSwift

extension DailyReportViewModelProtocol {

    func bind(to view: ReportView) -> CompositeDisposable {
        let disposeBag = CompositeDisposable()

        titleObservable.bind(to: view.titleLabel.rx.text).disposed(by: disposeBag)
        dayObservable.bind(to: view.dateLabel.rx.text).disposed(by: disposeBag)

        reportsViewModelObservable.subscribe(onNext: { viewModels in
            view.reportDetailsViews = viewModels.map { viewModel -> ReportDetailsView? in
                guard viewModel.type == .normal || viewModel.type == .paidVacations else { return nil }
                return ReportDetailsView(title: viewModel.title, subtitle: viewModel.subtitle)
            }.flatMap { $0 }
        }).disposed(by: disposeBag)

        return disposeBag
    }

}
