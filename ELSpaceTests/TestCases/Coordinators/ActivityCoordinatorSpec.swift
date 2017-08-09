import Quick
import Nimble

@testable import ELSpace

class ActivityCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("ActivityCoordinator") {

            var sut: ActivityCoordinator!
            var viewControllerFake: UIViewController!
            var activityViewControllerStub: ActivityViewControllerStub!
            var activityViewModelSpy: ActivityViewModelSpy!

            afterEach {
                sut = nil
                viewControllerFake = nil
                activityViewControllerStub = nil
                activityViewModelSpy = nil
            }

            beforeEach {
                viewControllerFake = UIViewController()
                activityViewControllerStub = ActivityViewControllerStub()
                activityViewModelSpy = ActivityViewModelSpy()
                sut = ActivityCoordinator(viewController: viewControllerFake,
                                          activityViewController: activityViewControllerStub,
                                          viewModel: activityViewModelSpy)
            }

            it("should have correct initial view controller") {
                expect(sut.initialViewController).to(equal(viewControllerFake))
            }

            context("when viewDidAppear") {
                beforeEach {
                    activityViewControllerStub.viewDidAppearSubject.onNext()
                }

                it("should view model call 'getData'") {
                    expect(activityViewModelSpy.didCallGetData).to(beTrue())
                }
            }

            context("when view model emit dataSource") {
                var fakeDataSource: [DailyReportViewModelProtocol]!

                beforeEach {
                    fakeDataSource = [DailyReportViewModel(date: Date(), reports: [], projects: [])]
                    activityViewModelSpy.dataSourceSubject.onNext(fakeDataSource)
                }

                describe("dataSource") {
                    it("should have correct number of elements") {
                        expect(activityViewControllerStub.viewModels).to(haveCount(1))
                    }
                }
            }
        }
    }

}
