import FBSnapshotTestCase

@testable import ELSpace

class ReportViewTests: FBSnapshotTestCase {

    var sut: ActivitiesView!

    override func setUp() {
        super.setUp()
        sut = ActivitiesView()
        recordMode = true
        isDeviceAgnostic = true
        sut.frame = UIScreen.main.bounds
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testReportViewCorrectDisplay() {
        sut.stackView.addArrangedSubview(fakeReportView)
        sut.stackView.addArrangedSubview(fakeReportViewAllCornersRounded)
        sut.stackView.addArrangedSubview(fakeReportViewTopCornersRounded)
        sut.stackView.addArrangedSubview(fakeReportViewBottomCornersRounded)
        sut.stackView.addArrangedSubview(fakeReportViewWithDetails)
        sut.stackView.addArrangedSubview(fakeReportViewWithSeparator)
        verifyView()
    }

    private func verifyView() {
        FBSnapshotVerifyView(sut)
        expectation(description: "Should display correct view").fulfill()
        waitForExpectations(timeout: 1.0)
    }

    // MARK: - ReportView fakes

    private var fakeReportView: ReportView {
        let view = ReportView()
        view.dateLabel.text = "fake_date"
        view.rightStripeView.backgroundColor = .red
        view.contentContainer.backgroundColor = .yellow
        view.titleLabel.text = "very very very very very very long title"
        view.addIconView.image = UIImage.fakeImage()
        view.separatorView.isHidden = true
        return view
    }

    private var fakeReportViewAllCornersRounded: ReportView {
        let view = fakeReportView
        view.areBottomCornersRounded = true
        view.areTopCornersRounded = true
        view.titleLabel.text = "All corners rounded"
        return view
    }

    private var fakeReportViewTopCornersRounded: ReportView {
        let view = fakeReportView
        view.areTopCornersRounded = true
        view.titleLabel.text = "Top corners rounded"
        return view
    }

    private var fakeReportViewBottomCornersRounded: ReportView {
        let view = fakeReportView
        view.areBottomCornersRounded = true
        view.titleLabel.text = "Bottom corners rounded"
        return view
    }

    private var fakeReportViewWithSeparator: ReportView {
        let view = fakeReportView
        view.separatorView.isHidden = false
        view.titleLabel.text = "Separator visible"
        return view
    }

    private var fakeReportViewWithDetails: ReportView {
        let view = fakeReportView
        view.titleLabel.text = "Report with content"
        view.reportDetailsViews = [fakeReportDetailsView, fakeReportDetailsViewWithLongTexts]
        return view
    }

    // MARK: - ReportDetailsView fakse

    private var fakeReportDetailsView: ReportDetailsView {
        return ReportDetailsView(title: "fake_title", subtitle: "fake_subtitle")
    }

    private var fakeReportDetailsViewWithLongTexts: ReportDetailsView {
        return ReportDetailsView(title: "very vrey very very very very very very very very very long title",
                                 subtitle: "very very very very very very very very long subtitle")
    }

}
