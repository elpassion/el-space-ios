import Quick
import Nimble
import RxTest

@testable import ELSpace

class ActivitiesViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ActivitiesViewController") {

            var sut: ActivitiesViewController!
            var scheduler: TestScheduler!
            var viewDidAppearObserver: TestableObserver<Void>!

            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
                viewDidAppearObserver = scheduler.createObserver(Void.self)
                sut = ActivitiesViewController()
            }

            afterEach {
                sut = nil
                scheduler = nil
                viewDidAppearObserver = nil
            }

            it("should throw fatalError when initailize with coder") {
                expect { sut = ActivitiesViewController(coder: NSCoder()) }.to(throwAssertion())
            }

            context("when viewDidAppear") {
                beforeEach {
                    _ = sut.viewDidAppear.subscribe(viewDidAppearObserver)
                    sut.viewDidAppear(true)
                }

                it("should emit next event") {
                    expect(viewDidAppearObserver.events).to(haveCount(1))
                }
            }
        }
    }

}
