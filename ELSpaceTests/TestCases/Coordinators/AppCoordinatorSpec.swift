import Quick
import Nimble
import UIKit

@testable import ELSpace

class AppCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("AppCoordinator") {

            var sut: AppCoordinator!
            var selectionCoordinatorFactoryMock: SelectionCoordinatorFactoryMock!
            var viewControllerPresenterSpy: ViewControllerPresenterSpy!
            var loginViewControllerFake: LoginViewControllerFake!
            var rootViewController: UIViewController!

            beforeEach {
                rootViewController = UIViewController()
                selectionCoordinatorFactoryMock = SelectionCoordinatorFactoryMock()
                viewControllerPresenterSpy = ViewControllerPresenterSpy()
                loginViewControllerFake = LoginViewControllerFake()
                sut = AppCoordinator(navigationController: UINavigationController(rootViewController: rootViewController),
                                     loginViewController: loginViewControllerFake,
                                     selectionCoordinatorFactory: selectionCoordinatorFactoryMock,
                                     viewControllerPresenter: viewControllerPresenterSpy)
            }

            afterEach {
                rootViewController = nil
                selectionCoordinatorFactoryMock = nil
                viewControllerPresenterSpy = nil
                loginViewControllerFake = nil
                sut = nil
            }

            context("when receive googleIdToken") {
                beforeEach {
                    loginViewControllerFake.googleTooken!("fake_token")
                }

                it("should call selection coordinator factory method") {
                    expect(selectionCoordinatorFactoryMock.didCallSelectionCoordinator).to(beTrue())
                }

                it("should present on correct view controller") {
                    expect(viewControllerPresenterSpy.presenter).to(equal(sut.initialViewController))
                }

                it("should push correct view controller") {
                    expect(viewControllerPresenterSpy.pushedViewController).to(equal(selectionCoordinatorFactoryMock.fakeCoordinator.initialViewController))
                }
            }

        }
    }

}
