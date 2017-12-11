import Quick
import Nimble

@testable import ELSpace

class ActivitiesCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("ActivitiesCoordinator") {

            var sut: ActivitiesCoordinator!
            var viewControllerFake: UIViewController!
            var activitiesViewControllerStub: ActivitiesViewControllerStub!
            var activitiesViewModelSpy: ActivitiesViewModelSpy!

            afterEach {
                sut = nil
                viewControllerFake = nil
                activitiesViewControllerStub = nil
                activitiesViewModelSpy = nil
            }

            beforeEach {
                viewControllerFake = UIViewController()
                activitiesViewControllerStub = ActivitiesViewControllerStub()
                activitiesViewModelSpy = ActivitiesViewModelSpy()
                sut = ActivitiesCoordinator(viewController: viewControllerFake,
                                            activitiesViewController: activitiesViewControllerStub,
                                            viewModel: activitiesViewModelSpy)
            }

            it("should have correct initial view controller") {
                expect(sut.initialViewController).to(equal(viewControllerFake))
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
        }
    }

}
