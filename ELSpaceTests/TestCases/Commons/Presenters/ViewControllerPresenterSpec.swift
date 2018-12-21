import Quick
import Nimble

@testable import ELSpace

class ViewControllerPresenterSpec: QuickSpec {

    override func spec() {
        describe("ViewControllerPresenter") {
            var sut: ViewControllerPresenter!

            beforeEach {
                sut = ViewControllerPresenter()
            }

            context("when presenting") {
                var presentedViewController: UIViewController!
                var presentingViewControllerSpy: UIViewControllerSpy!

                beforeEach {
                    presentedViewController = UIViewController(nibName: nil, bundle: nil)
                    presentingViewControllerSpy = UIViewControllerSpy(nibName: nil, bundle: nil)
                    sut.present(viewController: presentedViewController, on: presentingViewControllerSpy)
                }

                it("should present proper viewController") {
                    expect(presentingViewControllerSpy.viewControllerToPresent)
                        .to(be(presentedViewController))
                }

                it("should present with animation") {
                    expect(presentingViewControllerSpy.presentedWithAnimation).to(beTrue())
                }
            }

            context("when pushing") {
                var navigationControllerSpy: UINavigationControllerSpy!
                var rootViewController: UIViewController!
                var pushedViewController: UIViewController!

                beforeEach {
                    rootViewController = UIViewController(nibName: nil, bundle: nil)
                    navigationControllerSpy = UINavigationControllerSpy(rootViewController: rootViewController)
                    pushedViewController = UIViewController(nibName: nil, bundle: nil)
                    sut.push(viewController: pushedViewController, on: rootViewController)
                }

                it("should push proper viewController") {
                    expect(navigationControllerSpy.pushedViewController).to(be(pushedViewController))
                }

                it("should push with animation") {
                    expect(navigationControllerSpy.pushedWithAnimation).to(beTrue())
                }
            }

        }
    }

}
