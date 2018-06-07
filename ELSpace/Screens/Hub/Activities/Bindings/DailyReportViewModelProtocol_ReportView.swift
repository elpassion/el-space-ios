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

        view.rx.controlEvent(.touchUpInside)
            .bind(to: action)
            .disposed(by: disposeBag)

        Observable.just(reportsViewModel)
            .subscribe(onNext: { viewModels in
                view.reportDetailsViews = viewModels.map { viewModel -> ReportDetailsView? in
                    guard viewModel.type == .normal || viewModel.type == .paidVacations else { return nil }
                    let control = ReportDetailsView(title: viewModel.title, subtitle: viewModel.subtitle)
                    control.rx.controlEvent(.touchUpInside)
                        .bind(to: viewModel.action)
                        .disposed(by: disposeBag)
                    return control
                }.compactMap { $0 }
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

        return disposeBag
    }

}
