import Quick
import Nimble
import RxTest

@testable import ELSpace

class ActivityViewModelSpec: QuickSpec {

    override func spec() {
        describe("ActivityViewModel") {

            var sut: ActivityViewModel!
            var activityControllerSpy: ActivityControllerSpy!
            var scheduler: TestScheduler!
            var dataSourceObserver: TestableObserver<[DailyReportViewModelProtocol]>!

            afterEach {
                sut = nil
                activityControllerSpy = nil
                scheduler = nil
                dataSourceObserver = nil
            }

            beforeEach {
                activityControllerSpy = ActivityControllerSpy()
                sut = ActivityViewModel(activityController: activityControllerSpy)
                scheduler = TestScheduler(initialClock: 0)
                dataSourceObserver = scheduler.createObserver(Array<DailyReportViewModelProtocol>.self)
                _ = sut.dataSource.subscribe(dataSourceObserver)
                activityControllerSpy.projectsSubject.onNext([ProjectDTO.fakeProjectDto()])
                activityControllerSpy.reportsSubject.onNext([ReportDTO.fakeReportDto()])
            }

            it("should have correct month") {
                expect(sut.month).to(equal(DateFormatter.monthFormatter.string(from: Date())))
            }

            context("when call 'getData'") {
                beforeEach {
                    sut.getData()
                }

                it("should call 'getReports'") {
                    expect(activityControllerSpy.didCallGetReports).to(beTrue())
                }

                it("should call 'getProjects'") {
                    expect(activityControllerSpy.didCallGetProjects).to(beTrue())
                }

                it("should dataSource NOT emit any envets") {
                    expect(dataSourceObserver.events).to(haveCount(0))
                }

                context("when receive didFinishFetch event") {
                    beforeEach {
                        activityControllerSpy.didFinishFetchSubject.onNext(())
                    }

                    it("should dataSource emit one event") {
                        expect(dataSourceObserver.events).to(haveCount(1))
                    }
                }
            }
        }
    }

}
