import Quick
import Nimble
import RxSwift
import RxTest

@testable import ELSpace

class SelectionViewControllerSpec: QuickSpec {

    override func spec() {
        describe("SelectionViewController") {

            var sut: SelectionViewController!
            var navigationController: UINavigationController!
            var selectionControllerSpy: SelectionControllerSpy!
            var alertFactory: AlertFactoryFake!
            var viewControllerPresenterSpy: ViewControllerPresenterSpy!
            var scheduler: TestScheduler!
            var observer: TestableObserver<String>!

            afterEach {
                sut = nil
                navigationController = nil
                selectionControllerSpy = nil
                alertFactory = nil
                viewControllerPresenterSpy = nil
                scheduler = nil
                observer = nil
            }

            context("when try to initialize with init coder") {
                it("should throw fatalError") {
                    expect { sut = SelectionViewController(coder: NSCoder()) }.to(throwAssertion())
                }
            }

            context("after initialize") {
                beforeEach {
                    selectionControllerSpy = SelectionControllerSpy()
                    alertFactory = AlertFactoryFake()
                    viewControllerPresenterSpy = ViewControllerPresenterSpy()
                    sut = SelectionViewController(selectionController: selectionControllerSpy,
                                                  alertFactory: alertFactory,
                                                  viewControllerPresenter: viewControllerPresenterSpy)
                    navigationController = UINavigationController(rootViewController: sut)
                    scheduler = TestScheduler(initialClock: 0)
                    observer = scheduler.createObserver(String.self)
                }

                it("should have correct prefered status bar style") {
                    expect(sut.preferredStatusBarStyle == .lightContent).to(beTrue())
                }

                describe("view") {
                    it("should be kind of SelectionView") {
                        expect(sut.view as? SelectionView).toNot(beNil())
                    }

                    context("when appear") {
                        beforeEach {
                            sut.viewWillAppear(true)
                        }

                        it("should set navigation bar hidden") {
                            expect(navigationController.isNavigationBarHidden).to(beTrue())
                        }
                    }
                }

                context("when tap hub button and get token with success") {
                    beforeEach {
                        _ = sut.openHubWithToken.subscribe(observer)
                        selectionControllerSpy.token = "fake_token"
                        sut.selectionView.hubButton.sendActions(for: .touchUpInside)
                    }

                    describe("openHubWithToken") {
                        it("should emit on event") {
                            expect(observer.events).to(haveCount(1))
                        }

                        it("should emit correct token") {
                            expect(observer.events.first!.value.element!).to(equal("fake_token"))
                        }
                    }
                }

                context("when tap hub button and error occurs") {
                    beforeEach {
                        _ = sut.openHubWithToken.subscribe(observer)
                        selectionControllerSpy.error = NSError(domain: "fake_domain", code: 999, userInfo: nil)
                        sut.selectionView.hubButton.sendActions(for: .touchUpInside)
                    }

                    describe("openHubWithToken") {
                        it("should NOT emit any event") {
                            expect(observer.events).to(haveCount(0))
                        }
                    }

                    it("should present error on correct view controller") {
                        expect(viewControllerPresenterSpy.presenter).to(equal(sut))
                    }
                }
            }
        }
    }

}
