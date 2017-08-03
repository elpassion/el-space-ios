import Quick
import Nimble

@testable import ELSpace

class SelectionCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("SelectionCoordinator") {

            var sut: SelectionCoordinator!
            var selectionViewControllerStub: SelectionViewControllerStub!
            var selectionScreenPresenterMock: SelectionScreenPresenterMock!
            var viewControllerFake: UIViewController!
            var hubSession: HubSession!

            beforeEach {
                hubSession = HubSession()
                selectionViewControllerStub = SelectionViewControllerStub()
                selectionScreenPresenterMock = SelectionScreenPresenterMock()
                viewControllerFake = UIViewController()
                sut = SelectionCoordinator(viewController: viewControllerFake,
                                           selectionViewController: selectionViewControllerStub,
                                           selectionScreenPresenter: selectionScreenPresenterMock,
                                           hubSession: hubSession)
            }

            it("should have correrct initial view controller") {
                expect(sut.initialViewController).to(equal(viewControllerFake))
            }

            afterEach {
                selectionViewControllerStub = nil
                selectionScreenPresenterMock = nil
                hubSession = nil
                viewControllerFake = nil
                sut = nil
            }

            context("when selection view controller emit openDebate next event") {
                beforeEach {
                    selectionViewControllerStub.openDebateSubject.onNext()
                }

                it("should call presentDebate") {
                    expect(selectionScreenPresenterMock.didCallPresentDebate).to(beTrue())
                }
            }

            context("when selection view controller emit openHubWithToken next event") {
                beforeEach {
                    selectionViewControllerStub.openHubWithTokenSubject.onNext("fake_token")
                }

                it("should call presentHub") {
                    expect(selectionScreenPresenterMock.didCallPresentHub).to(beTrue())
                }

                it("should hubSession have correct token") {
                    expect(hubSession.accessToken).to(equal("fake_token"))
                }
            }
        }
    }

}
