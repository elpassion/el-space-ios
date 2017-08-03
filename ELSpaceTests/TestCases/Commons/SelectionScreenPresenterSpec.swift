import Quick
import Nimble

@testable import ELSpace

class SelectionScreenPresenterSpec: QuickSpec {

    override func spec() {
        describe("SelectionScreenPresenter") {

            var sut: SelectionScreenPresenter!
            var debateRunnerSpy: DebateRunnerSpy!
            var activityCoordinatorFactoryMock: ActivityCoordinatorFactoryMock!
            var viewControllerPresenterSpy: ViewControllerPresenterSpy!
            var viewControllerFake: UIViewController!
            var navigationControllerFake: UINavigationController!

            beforeEach {
                debateRunnerSpy = DebateRunnerSpy()
                activityCoordinatorFactoryMock = ActivityCoordinatorFactoryMock()
                viewControllerPresenterSpy = ViewControllerPresenterSpy()
                viewControllerFake = UIViewController()
                navigationControllerFake = UINavigationController(rootViewController: viewControllerFake)
                sut = SelectionScreenPresenter(debateRunner: debateRunnerSpy,
                                               activityCoordinatorFactory: activityCoordinatorFactoryMock,
                                               viewControllerPresenter: viewControllerPresenterSpy,
                                               presenterViewController: viewControllerFake)
            }

            afterEach {
                debateRunnerSpy = nil
                activityCoordinatorFactoryMock = nil
                viewControllerPresenterSpy = nil
                viewControllerFake = nil
                navigationControllerFake = nil
                sut = nil
            }

            context("when present debate") {
                beforeEach {
                    sut.presentDebate()
                }

                it("should present debate on correct view controller") {
                    expect(debateRunnerSpy.navigationController).to(equal(navigationControllerFake))
                }
            }

            context("when present hub") {
                beforeEach {
                    sut.presentHub()
                }

                it("should present hub on correct view controller") {
                    expect(viewControllerPresenterSpy.presenter).to(equal(viewControllerFake))
                }

                it("should present correct view controller") {
                    expect(viewControllerPresenterSpy.pushedViewController)
                        .to(equal(activityCoordinatorFactoryMock.fakeCoordinator.initialViewController))
                }
            }
        }
    }

}
