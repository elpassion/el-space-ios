import Quick
import Nimble
import RxTest

@testable import ELSpace

class ActivityViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ActivityViewController") {

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

            context("when set dataSource") {
                beforeEach {
                    sut.viewModels = [
                        DailyReportViewModel(date: Date(), reports: [], projects: [])
                    ]
                }

                it("should have correct numer of sections") {
                    expect(sut.numberOfSections(in: sut.tableView)).to(equal(1))
                }

                it("should have correct number of rows in 0 section") {
                    expect(sut.tableView(sut.tableView, numberOfRowsInSection: 0)).to(equal(1))
                }

                it("should return correct cell") {
                    expect(sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ReportCell).toNot(beNil())
                }
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
