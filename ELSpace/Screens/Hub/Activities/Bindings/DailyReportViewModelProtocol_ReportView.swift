import RxSwift

extension DailyReportViewModelProtocol {

    func bind(to view: ReportView) -> CompositeDisposable {
        let disposeBag = CompositeDisposable()

        Observable.just(title)
            .bind(to: view.titleLabel.rx.attributedText)
            .disposed(by: disposeBag)

        Observable.just(day)
            .bind(to: view.dateLabel.rx.attributedText)
            .disposed(by: disposeBag)

        Observable.just(reportsViewModel)
            .subscribe(onNext: { viewModels in
                view.reportDetailsViews = viewModels.map { viewModel -> ReportDetailsView? in
                    guard viewModel.type == .normal || viewModel.type == .paidVacations else { return nil }
                    let view = ReportDetailsView(title: viewModel.title, subtitle: viewModel.subtitle)
                    view.rx.controlEvent(.touchUpInside)
                        .bind(to: viewModel.tapOnReportDetails)
                        .disposed(by: viewModel.disposeBag)
                    return view
                }.flatMap { $0 }
        }).disposed(by: disposeBag)

        Observable.just(stripeColor)
            .bind(to: view.rightStripeView.rx.backgroundColor)
            .disposed(by: disposeBag)

        Observable.just(backgroundColor)
            .bind(to: view.contentContainer.rx.backgroundColor)
            .disposed(by: disposeBag)

        Observable.just(topCornersRounded)
            .subscribe(onNext: { [weak view] in view?.areTopCornersRounded = $0 })
            .disposed(by: disposeBag)

        Observable.just(bottomCornersRounded)
            .subscribe(onNext: { [weak view] in view?.areBottomCornersRounded = $0 })
            .disposed(by: disposeBag)

        Observable.just(isSeparatorHidden)
            .subscribe(onNext: { [weak view] in view?.separatorView.isHidden = $0 })
            .disposed(by: disposeBag)

//        view.contentContainer.rx.controlEvent(.touchUpInside)
//            .bind(to: didTapOnReport)
//            .disposed(by: disposeBag)

        return disposeBag
    }

}
