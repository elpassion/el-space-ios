import Quick
import Nimble

@testable import ELSpace

class ActivitiesCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("ActivitiesCoordinator") {

            var sut: ActivitiesCoordinator!
            var activitiesViewControllerStub: ActivitiesViewControllerStub!
            var activitiesViewModelSpy: ActivitiesViewModelSpy!
            var presenterSpy: ViewControllerPresenterSpy!
            var activityCoordinatorCreationStub: ActivityCoordinatorCreationStub!

            afterEach {
                sut = nil
                activitiesViewControllerStub = nil
                activitiesViewModelSpy = nil
                presenterSpy = nil
                activityCoordinatorCreationStub = nil
            }

            beforeEach {
                activitiesViewControllerStub = ActivitiesViewControllerStub()
                activitiesViewModelSpy = ActivitiesViewModelSpy()
                presenterSpy = ViewControllerPresenterSpy()
                activityCoordinatorCreationStub = ActivityCoordinatorCreationStub()
                sut = ActivitiesCoordinator(activitiesViewController: activitiesViewControllerStub,
                                            activitiesViewModel: activitiesViewModelSpy,
                                            presenter: presenterSpy,
                                            activityCoordinatorFactory: activityCoordinatorCreationStub)
            }

            it("should have correct initial view controller") {
                expect(sut.initialViewController).to(equal(activitiesViewControllerStub))
            }

            context("when viewDidAppear") {
                beforeEach {
                    activitiesViewControllerStub.viewDidAppearSubject.onNext(())
                }

                it("should view model call 'getData'") {
                    expect(activitiesViewModelSpy.didCallGetData).to(beTrue())
                }
            }

            context("when view model emit dataSource") {
                var fakeDataSource: [DailyReportViewModelProtocol]!

                beforeEach {
                    fakeDataSource = [DailyReportViewModel(date: Date(), todayDate: Date(), reports: [], projects: [], isHoliday: false)]
                    activitiesViewModelSpy.dataSourceSubject.onNext(fakeDataSource)
                }

                describe("dataSource") {
                    it("should have correct number of elements") {
                        expect(activitiesViewControllerStub.viewModels).to(haveCount(1))
                    }
                }
            }

            context("when presenting activity screen") {
                beforeEach {
                    let report = ReportDTO(id: 1, userId: 1, projectId: 1, value: "1", performedAt: "1", comment: "1", createdAt: "1", updatedAt: "1", billable: true, reportType: 1)
                    activitiesViewModelSpy.openReportSubject.onNext((date: Date(), report: report, projects: []))
                }

                it("should push activity screen") {
                    expect(presenterSpy.pushedViewController)
                        .to(be(activityCoordinatorCreationStub.coordinatorStub.initialViewController))
                }
            }
        }
    }

}
