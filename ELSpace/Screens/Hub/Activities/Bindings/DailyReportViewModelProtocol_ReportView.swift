import RxSwift

extension ActivitiesViewController {

    func bind(viewModel: DailyReportViewModelProtocol, to view: ReportView) -> CompositeDisposable {
        let disposeBag = CompositeDisposable()

        view.titleLabel.attributedText = viewModel.title
        view.dateLabel.attributedText = viewModel.day
        view.rightStripeView.backgroundColor = viewModel.stripeColor
        view.contentContainer.backgroundColor = viewModel.backgroundColor
        view.areTopCornersRounded = viewModel.topCornersRounded
        view.areBottomCornersRounded = viewModel.bottomCornersRounded
        view.separatorView.isHidden = viewModel.isSeparatorHidden
        view.addIconView.isHidden = viewModel.hideAddReportButton

        view.reportDetailsViews = viewModel.reportsViewModel.map { viewModel -> ReportDetailsView? in
            guard viewModel.type == .normal || viewModel.type == .paidVacations else { return nil }
            let control = ReportDetailsView(title: viewModel.title, subtitle: viewModel.subtitle)
            control.rx.controlEvent(.touchUpInside)
                .bind(to: viewModel.action)
                .disposed(by: viewModel.disposeBag)
            return control
        }.compactMap { $0 }

        return disposeBag
    }

}
