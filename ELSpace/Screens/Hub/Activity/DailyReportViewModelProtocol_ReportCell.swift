import RxSwift

extension DailyReportViewModelProtocol {

    func bind(to cell: ReportCell) -> CompositeDisposable {
        let disposeBag = CompositeDisposable()

        titleObservable.bind(to: cell.view.titleLabel.rx.text).disposed(by: disposeBag)
        dayObservable.bind(to: cell.view.dateLabel.rx.text).disposed(by: disposeBag)

        reportsViewModelObservable.subscribe(onNext: { viewModels in
            cell.view.reportDetailsViews = viewModels.map({ (viewModel) -> ReportDetailsView in
                ReportDetailsView(title: viewModel.title, subtitle: viewModel.subtitle)
            })
        }).disposed(by: disposeBag)

        return disposeBag
    }

}
