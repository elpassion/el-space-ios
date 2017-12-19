import Quick
import Nimble
import Nimble_Snapshots
import FBSnapshotTestCase

@testable import ELSpace

class ActivitiesViewTests: QuickSpec {

    override func spec() {
        describe("ActivitiesViewTests") {

            var sut: ActivitiesView!

            beforeEach {
                sut = ActivitiesView()
                sut.frame = UIScreen.main.bounds
            }

            context("when initalize with coder") {
                it("should throw fatal error") {
                    expect { _ = ReportView(coder: NSCoder()) }.to(throwAssertion())
                }
            }

            describe("6 different ReportView") {
                beforeEach {
                    sut.stackView.addArrangedSubview(self.fakeReportView)
                    sut.stackView.addArrangedSubview(self.fakeReportViewAllCornersRounded)
                    sut.stackView.addArrangedSubview(self.fakeReportViewTopCornersRounded)
                    sut.stackView.addArrangedSubview(self.fakeReportViewBottomCornersRounded)
                    sut.stackView.addArrangedSubview(self.fakeReportViewWithDetails)
                    sut.stackView.addArrangedSubview(self.fakeReportViewWithSeparator)
                }

                it("should have valid snapshot") {
                    expect(sut).to(haveValidDeviceAgnosticSnapshot())
                }
            }

        }
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
