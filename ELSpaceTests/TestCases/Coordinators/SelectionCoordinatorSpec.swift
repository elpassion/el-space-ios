import Quick
import Nimble

@testable import ELSpace

class SelectionCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("SelectionCoordinator") {

            var sut: SelectionCoordinator!
            var viewControllerFake: UIViewController!
            var navigationControllerFake: UIViewController!
            var debateRunnerSpy: DebateRunnerSpy!
            var selectionViewControllerStub: SelectionViewControllerStub!
            var activityCoordinatorFactoryMock: ActivityCoordinatorFactoryMock!
            var viewControllerPresenterSpy: ViewControllerPresenterSpy!

            beforeEach {
                viewControllerFake = UIViewController()
                navigationControllerFake = UINavigationController(rootViewController: viewControllerFake)
                debateRunnerSpy = DebateRunnerSpy()
                selectionViewControllerStub = SelectionViewControllerStub()
                activityCoordinatorFactoryMock = ActivityCoordinatorFactoryMock()
                viewControllerPresenterSpy = ViewControllerPresenterSpy()
                sut = SelectionCoordinator(debateRunner: debateRunnerSpy,
                                           viewController: viewControllerFake,
                                           selectionViewController: selectionViewControllerStub,
                                           activityCoordinatorFactory: activityCoordinatorFactoryMock,
                                           viewControllerPresenter: viewControllerPresenterSpy)
            }

            afterEach {
                sut = nil
                viewControllerFake = nil
                navigationControllerFake = nil
                debateRunnerSpy = nil
                selectionViewControllerStub = nil
                activityCoordinatorFactoryMock = nil
                viewControllerPresenterSpy = nil
            }

            it("should have correct initial view controller") {
                expect(sut.initialViewController).to(equal(viewControllerFake))
            }

            context("when receive open debate event") {
                beforeEach {
                    selectionViewControllerStub.openDebateSubject.onNext()
                }

                it("should open debate on correct navigation controller") {
                    expect(debateRunnerSpy.navigationController).to(equal(navigationControllerFake))
                }

                it("should apply debate style") {
                    expect(debateRunnerSpy.applyingDebateStyle).to(beTrue())
                }
            }

            context("when receive open hub event") {
                beforeEach {
                    selectionViewControllerStub.openHubWithTokenSubject.onNext("fake_token")
                }

                it("should push correct view controller") {
                    expect(viewControllerPresenterSpy.pushedViewController).to(equal(activityCoordinatorFactoryMock.fakeCoordinator.initialViewController))
                }

                it("should push on correct view controller") {
                    expect(viewControllerPresenterSpy.presenter).to(equal(viewControllerFake))
                }
            }
        }
    }

}
