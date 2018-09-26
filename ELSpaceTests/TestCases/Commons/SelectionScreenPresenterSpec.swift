import Quick
import Nimble

@testable import ELSpace

class SelectionScreenPresenterSpec: QuickSpec {

    override func spec() {
        describe("SelectionScreenPresenter") {

            var sut: SelectionScreenPresenter!
            var activitiesCoordinatorFactoryMock: ActivitiesCoordinatorFactoryMock!
            var viewControllerPresenterSpy: ViewControllerPresenterSpy!
            var viewControllerFake: UIViewController!

            beforeEach {
                activitiesCoordinatorFactoryMock = ActivitiesCoordinatorFactoryMock()
                viewControllerPresenterSpy = ViewControllerPresenterSpy()
                viewControllerFake = UIViewController()
                sut = SelectionScreenPresenter(activitiesCoordinatorFactory: activitiesCoordinatorFactoryMock,
                                               viewControllerPresenter: viewControllerPresenterSpy,
                                               presenterViewController: viewControllerFake)
            }

            afterEach {
                activitiesCoordinatorFactoryMock = nil
                viewControllerPresenterSpy = nil
                viewControllerFake = nil
                sut = nil
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
                        .to(equal(activitiesCoordinatorFactoryMock.fakeCoordinator.initialViewController))
                }
            }
        }
    }

}
