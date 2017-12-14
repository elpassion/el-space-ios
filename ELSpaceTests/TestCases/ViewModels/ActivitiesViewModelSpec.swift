import Quick
import Nimble
import RxTest

@testable import ELSpace

class ActivitiesViewModelSpec: QuickSpec {

    override func spec() {
        describe("ActivitiesViewModel") {

            var sut: ActivitiesViewModel!
            var activitiesControllerSpy: ActivitiesControllerSpy!
            var scheduler: TestScheduler!
            var dataSourceObserver: TestableObserver<[DailyReportViewModelProtocol]>!

            afterEach {
                sut = nil
                activitiesControllerSpy = nil
                scheduler = nil
                dataSourceObserver = nil
            }

            beforeEach {
                activitiesControllerSpy = ActivitiesControllerSpy()
                sut = ActivitiesViewModel(activitiesController: activitiesControllerSpy,
                                          todayDate: DateFormatter.shortDateFormatter.date(from: "2017-12-05")!)
                scheduler = TestScheduler(initialClock: 0)
                dataSourceObserver = scheduler.createObserver(Array<DailyReportViewModelProtocol>.self)
                _ = sut.dataSource.subscribe(dataSourceObserver)
                activitiesControllerSpy.projectsSubject.onNext([ProjectDTO.fakeProjectDto()])
                activitiesControllerSpy.reportsSubject.onNext([ReportDTO.fakeReportDto()])
            }

            it("should have correct month") {
                expect(sut.month).to(equal(DateFormatter.monthFormatter.string(from: Date())))
            }

            context("when call 'getData'") {
                beforeEach {
                    sut.getData()
                }

                it("should call 'getReports'") {
                    expect(activitiesControllerSpy.didCallGetReports).to(beTrue())
                }

                it("should call 'getProjects'") {
                    expect(activitiesControllerSpy.didCallGetProjects).to(beTrue())
                }

                it("should dataSource NOT emit any envets") {
                    expect(dataSourceObserver.events).to(haveCount(0))
                }

                context("when receive didFinishFetch event") {
                    beforeEach {
                        activitiesControllerSpy.didFinishFetchSubject.onNext(())
                    }

                    it("should dataSource emit one event") {
                        expect(dataSourceObserver.events).to(haveCount(1))
                    }
                }
            }
        }
    }

}
