import Quick
import Nimble
import UIKit

@testable import ELSpace

class ModalViewControllerPresenterSpec: QuickSpec {

    override func spec() {
        describe("ModalViewControllerPresenter") {
            var sut: ModalViewControllerPresenter!
            var presentTransitionStub: TransitionStub!
            var dismissTransitionStub: TransitionStub!

            beforeEach {
                presentTransitionStub = TransitionStub()
                dismissTransitionStub = TransitionStub()
                let configuration = ModalPresentationConfiguration(
                    animated: false,
                    presentTransition: presentTransitionStub,
                    dismissTransition: dismissTransitionStub,
                    presentationStyle: .overFullScreen)
                sut = ModalViewControllerPresenter(configuration: configuration)
            }

            it("should return correct presentAnimationController") {
                let presentAnimationController = sut.animationController(
                    forPresented: UIViewController(),
                    presenting: UIViewController(),
                    source: UIViewController()
                )
                expect(presentAnimationController).to(be(presentTransitionStub))
            }

            it("should return correct dismissAnimationController") {
                let dismissAnimationController = sut.animationController(
                    forDismissed: UIViewController()
                )
                expect(dismissAnimationController).to(be(dismissTransitionStub))
            }

            context("when presenting") {
                var viewController: UIViewController!
                var baseViewControllerSpy: ViewControllerSpy!

                beforeEach {
                    viewController = UIViewController()
                    baseViewControllerSpy = ViewControllerSpy()
                    sut.present(viewController: viewController, on: baseViewControllerSpy)
                }

                it("should view controller has correct modal presentation style") {
                    expect(viewController.modalPresentationStyle).to(equal(UIModalPresentationStyle.overFullScreen))
                }

                it("should view controller has correct transitioning delegate") {
                    expect(viewController.transitioningDelegate).to(be(sut))
                }

                it("should present correct viewController") {
                    expect(baseViewControllerSpy.didPresentViewController).to(be(viewController))
                }
            }

            context("when dissmissing") {
                var viewControllerSpy: ViewControllerSpy!

                beforeEach {
                    viewControllerSpy = ViewControllerSpy()
                    sut.dismiss(viewController: viewControllerSpy)
                }

                it("should view controller has correct modal presentation style") {
                    expect(viewControllerSpy.modalPresentationStyle).to(equal(UIModalPresentationStyle.overFullScreen))
                }

                it("should view controller has correct transitioning delegate") {
                    expect(viewControllerSpy.transitioningDelegate).to(be(sut))
                }

                it("should dismiss") {
                    expect(viewControllerSpy.didDismiss).to(beTrue())
                }
            }
        }
    }
}
