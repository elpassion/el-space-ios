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
                sut = ModalViewControllerPresenter(
                    presentTransition: { presentTransitionStub },
                    dismissTransition: { dismissTransitionStub }
                )
            }

            it("should has correct animation controller for presenting") {
                let controller = sut.animationController(forPresented: UIViewController(),
                                                         presenting: UIViewController(),
                                                         source: UIViewController())
                expect(controller).to(be(presentTransitionStub))
            }

            it("should has correct animation controller for dismissing") {
                let controller = sut.animationController(forDismissed: UIViewController())
                expect(controller).to(be(dismissTransitionStub))
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

                it("should present") {
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

    private class TransitionStub: NSObject, UIViewControllerAnimatedTransitioning {

        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0
        }

        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {}

    }

    private class ViewControllerSpy: UIViewController {

        var didPresentViewController: UIViewController?
        var didDismiss = false

        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            super.present(viewControllerToPresent, animated: flag, completion: completion)
            didPresentViewController = viewControllerToPresent
        }

        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            super.dismiss(animated: flag, completion: completion)
            didDismiss = true
        }

    }

}
