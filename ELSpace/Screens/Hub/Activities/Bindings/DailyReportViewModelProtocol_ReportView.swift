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

        stripeColorObservable.bind(to: view.rightStripeView.rx.backgroundColor).disposed(by: disposeBag)
        backgroundColorObservable.bind(to: view.contentContainer.rx.backgroundColor).disposed(by: disposeBag)

        Observable.just(topCornersRounded)
            .subscribe(onNext: { [weak view] in
                view?.areTopCornersRounded = $0
        }).disposed(by: disposeBag)

        Observable.just(bottomCornersRounded)
            .subscribe(onNext: { [weak view] in
                view?.areBottomCornersRounded = $0
            }).disposed(by: disposeBag)

        Observable.just(isSeparatorHidden)
            .subscribe(onNext: { [weak view] in
                view?.separatorView.isHidden = $0
            }).disposed(by: disposeBag)

        return disposeBag
    }

}