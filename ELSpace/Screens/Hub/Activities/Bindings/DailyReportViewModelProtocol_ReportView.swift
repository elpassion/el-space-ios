import RxSwift

extension ActivitiesViewController {

    func bind(viewModel: DailyReportViewModelProtocol, to view: ReportView) -> CompositeDisposable {
        let disposeBag = CompositeDisposable()

        view.titleLabel.attributedText = viewModel.title
        view.dateLabel.attributedText = viewModel.day
        view.rightStripeView.backgroundColor = viewModel.stripeColor
        view.contentContainer.backgroundColor = viewModel.backgroundColor
        view.areTopCornersRounded = viewModel.topCornersRounded
        view.areTopCornersRounded = viewModel.bottomCornersRounded
        view.separatorView.isHidden = viewModel.isSeparatorHidden
        view.addIconView.isHidden = viewModel.hideAddReportButton

        view.reportDetailsViews = viewModel.reportsViewModel.map { viewModel -> ReportDetailsView? in
            guard viewModel.type == .normal || viewModel.type == .paidVacations else { return nil }
            return ReportDetailsView(title: viewModel.title, subtitle: viewModel.subtitle)
        }.compactMap { $0 }

        view.contentContainer.rx.controlEvent(.touchUpInside)
            .bind(to: viewModel.didTapOnReport)
            .disposed(by: disposeBag)

        return disposeBag
    }

}
