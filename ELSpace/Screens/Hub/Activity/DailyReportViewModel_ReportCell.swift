import RxSwift

extension DailyReportViewModel {

    func bind(to cell: ReportCell) -> CompositeDisposable {
        let disposeBag = CompositeDisposable()

        Observable.just(day).bind(to: cell.view.dateLabel.rx.text).disposed(by: disposeBag)
        Observable.just(title).bind(to: cell.view.titleLabel.rx.text).disposed(by: disposeBag)

        Observable.just(reportsViewModel).subscribe(onNext: { viewModels in
            cell.view.reportDetailsViews = viewModels.map({ (viewModel) -> ReportDetailsView in
                ReportDetailsView(title: viewModel.title, subtitle: viewModel.subtitle)
            })
        }).disposed(by: disposeBag)

        return disposeBag
    }

}
