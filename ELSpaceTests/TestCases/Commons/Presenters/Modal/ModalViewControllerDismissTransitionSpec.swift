import Quick
import Nimble

@testable import ELSpace

class ModalViewControllerDismissTransitionSpec: QuickSpec {

    override func spec() {
        describe("ModalViewControllerDismissTransition") {
            var sut: ModalViewControllerDismissTransition<AnimatorMock>!
            var animatorMock: AnimatorMock.Type!

            beforeEach {
                animatorMock = AnimatorMock.self
                animatorMock.prepare()
                sut = ModalViewControllerDismissTransition(animator: animatorMock)
            }

            it("should has correct transition duration") {
                expect(sut.transitionDuration(using: nil)).to(equal(0.4))
            }

            context("when animating without from view") {
                beforeEach {
                    sut.animateTransition(using: ViewControllerTransitionContextStub())
                }

                it("should not animate") {
                    expect(animatorMock.animatingWithDuration).to(beNil())
                }
            }

            context("when animating") {
                var transitionContextStub: ViewControllerTransitionContextStub!
                var targetView: UIView!
                var backgroundView: ModalViewControllerBackgroundView!

                beforeEach {
                    targetView = UIView()
                    backgroundView = ModalViewControllerBackgroundView()
                    transitionContextStub = ViewControllerTransitionContextStub()
                    transitionContextStub.stubbedFromView = targetView
                    transitionContextStub.containerView.addSubview(backgroundView)
                    transitionContextStub.containerView.addSubview(targetView)
                    sut.animateTransition(using: transitionContextStub)
                }

                it("should animate with correct duration") {
                    expect(animatorMock.animatingWithDuration).to(equal(sut.transitionDuration(using: nil)))
                }

                context("when performing animations") {
                    beforeEach {
                        animatorMock.animations?()
                    }

                    it("should target view have correct alpha") {
                        expect(targetView.alpha).to(equal(0))
                    }

                    it("should target view have correct transform") {
                        expect(targetView.transform).to(equal(CGAffineTransform(translationX: 0, y: 200)))
                    }

                    it("should background view be correctly configured") {
                        expect(backgroundView.alpha).to(equal(0))
                    }

                    context("when animations completes") {
                        beforeEach {
                            animatorMock.completion?(true)
                        }

                        it("should complete transition") {
                            expect(transitionContextStub.invokedCompleteTransition?.count) == 1
                            expect(transitionContextStub.invokedCompleteTransition?.didComplete) == true
                        }

                        it("should target view have correct alpha") {
                            expect(targetView.superview).to(beNil())
                        }

                        it("should target view have correct transform") {
                            expect(targetView.transform).to(equal(CGAffineTransform.identity))
                        }

                        it("should background view be correctly configured") {
                            expect(backgroundView?.superview).to(beNil())
                        }
                    }
                }
            }
        }
    }

}
