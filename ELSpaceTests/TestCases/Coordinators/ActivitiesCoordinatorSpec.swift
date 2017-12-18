import Quick
import Nimble

@testable import ELSpace

class ActivitiesCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("ActivitiesCoordinator") {

            var sut: ActivitiesCoordinator!
            var activityCreatorStub: ActivityCreatorStub!
            var activitiesViewControllerStub: ActivitiesViewControllerStub!
            var activitiesViewModelSpy: ActivitiesViewModelSpy!
            var presenterSpy: ViewControllerPresenterSpy!

            afterEach {
                sut = nil
                activityCreatorStub = nil
                activitiesViewControllerStub = nil
                activitiesViewModelSpy = nil
                presenterSpy = nil
            }

            beforeEach {
                activityCreatorStub = ActivityCreatorStub()
                activitiesViewControllerStub = ActivitiesViewControllerStub()
                activitiesViewModelSpy = ActivitiesViewModelSpy()
                presenterSpy = ViewControllerPresenterSpy()
                sut = ActivitiesCoordinator(activityCreator: activityCreatorStub,
                                            activitiesViewController: activitiesViewControllerStub,
                                            activitiesViewModel: activitiesViewModelSpy,
                                            presenter: presenterSpy)
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
                    fakeDataSource = [DailyReportViewModel(date: Date(), reports: [], projects: [])]
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
                    activitiesViewControllerStub.addActivitySubject.onNext(())
                }

                it("should push activity screen") {
                    expect(presenterSpy.pushedViewController).to(be(activityCreatorStub.viewController))
                }
            }
        }
    }

}
