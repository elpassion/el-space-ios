import Quick
import Nimble

@testable import ELSpace

class ModalViewControllerPresentTransitionSpec: QuickSpec {

    override func spec() {
        describe("ModalViewControllerPresentTransition") {
            var sut: ModalViewControllerPresentTransition!
            var animatorMock: AnimatorMock.Type!

            beforeEach {
                animatorMock = AnimatorMock.self
                animatorMock.prepare()
                sut = ModalViewControllerPresentTransition(animator: animatorMock)
            }

            it("should has correct transition duration") {
                expect(sut.transitionDuration(using: nil)).to(equal(0.4))
            }

            context("when animating without to view") {
                beforeEach {
                    sut.animateTransition(using: ViewControllerTransitionContextStub())
                }

                it("should not animate") {
                    expect(animatorMock.animatingWithDuration).to(beNil())
                }
            }

            context("when animating") {
                var transitionContext: ViewControllerTransitionContextStub!

                beforeEach {
                    transitionContext = ViewControllerTransitionContextStub()
                    transitionContext.stubbedToView = UIView()
                    sut.animateTransition(using: transitionContext)
                }

                describe("target view") {
                    var targetView: UIView?

                    beforeEach {
                        targetView = transitionContext.containerView.subviews.first(where: {
                            $0.isEqual(transitionContext.stubbedToView)
                        })
                    }

                    it("should not be nil") {
                        expect(targetView).notTo(beNil())
                    }

                    it("should have correct alpha") {
                        expect(targetView?.alpha).to(equal(0))
                    }

                    it("should have correct transform") {
                        expect(targetView?.transform).to(equal(CGAffineTransform(translationX: 0, y: 200)))
                    }
                }

                describe("background view") {
                    var backgroundView: UIView?

                    beforeEach {
                        backgroundView = transitionContext.containerView.subviews.first(where: {
                            $0.isKind(of: ModalViewControllerBackgroundView.self)
                        })
                    }

                    it("should not be nil") {
                        expect(backgroundView).notTo(beNil())
                    }

                    it("should have correct alpha") {
                        expect(backgroundView?.alpha).to(equal(0))
                    }
                }

                it("should animate with correct duration") {
                    expect(animatorMock.animatingWithDuration).to(equal(sut.transitionDuration(using: nil)))
                }

                context("when performing animations") {
                    beforeEach {
                        animatorMock.animations?()
                        animatorMock.completion?(true)
                    }

                    it("should complete transition") {
                        expect(transitionContext.invokedCompleteTransition?.count) == 1
                        expect(transitionContext.invokedCompleteTransition?.didComplete) == true
                    }

                    describe("target view") {
                        var targetView: UIView?

                        beforeEach {
                            targetView = transitionContext.containerView.subviews.first(where: {
                                $0.isEqual(transitionContext.stubbedToView)
                            })
                        }

                        it("should not be nil") {
                            expect(targetView).notTo(beNil())
                        }

                        it("should have correct alpha") {
                            expect(targetView?.alpha).to(equal(1))
                        }

                        it("should have correct transform") {
                            expect(targetView?.transform).to(equal(CGAffineTransform.identity))
                        }
                    }

                    describe("background view") {
                        var backgroundView: UIView?

                        beforeEach {
                            backgroundView = transitionContext.containerView.subviews.first(where: {
                                $0.isKind(of: ModalViewControllerBackgroundView.self)
                            })
                        }

                        it("should not be nil") {
                            expect(backgroundView).notTo(beNil())
                        }

                        it("should have correct alpha") {
                            expect(backgroundView?.alpha).to(equal(1))
                        }
                    }
                }
            }
        }
    }

}
