import Quick
import Nimble
import RxTest

@testable import ELSpace

class ActivitiesControllerSpec: QuickSpec {

    override func spec() {
        describe("ActivitiesController") {

            var sut: ActivitiesController!
            var reportsServiceStub: ReportsServiceStub!
            var projectsServiceStub: ProjectsServiceStub!
            var holidaysServiceStub: HolidaysServiceStub!
            var reportsResultFake: [ReportDTO]!
            var projectsResultFake: [ProjectDTO]!
            var reportObserver: TestableObserver<[ReportDTO]>!
            var projectObserver: TestableObserver<[ProjectDTO]>!
            var didFinishFetchObserver: TestableObserver<Void>!
            var isLoadingObserver: TestableObserver<Bool>!
            var scheduler: TestScheduler!

            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
                reportObserver = scheduler.createObserver(Array<ReportDTO>.self)
                projectObserver = scheduler.createObserver(Array<ProjectDTO>.self)
                didFinishFetchObserver = scheduler.createObserver(Void.self)
                isLoadingObserver = scheduler.createObserver(Bool.self)
                reportsResultFake = [ ReportDTO.fakeReportDto() ]
                projectsResultFake = [ ProjectDTO.fakeProjectDto() ]
                reportsServiceStub = ReportsServiceStub()
                holidaysServiceStub = HolidaysServiceStub()
                reportsServiceStub.result = reportsResultFake
                projectsServiceStub = ProjectsServiceStub()
                projectsServiceStub.result = projectsResultFake
                sut = ActivitiesController(reportsService: reportsServiceStub,
                                           projectsService: projectsServiceStub,
                                           holidaysService: holidaysServiceStub)
                _ = sut.reports.subscribe(reportObserver)
                _ = sut.projects.subscribe(projectObserver)
                _ = sut.didFinishFetch.subscribe(didFinishFetchObserver)
                _ = sut.isLoading.subscribe(isLoadingObserver)
            }

            context("when fetch data") {
                beforeEach {
                    sut.fetchData(from: "fake_from", to: "fake_to")
                }

                it("should 'reports' emit one next event") {
                    expect(reportObserver.events).to(haveCount(1))
                }

                it("should 'projects' emit one next event") {
                    expect(reportObserver.events).to(haveCount(1))
                }

                it("should 'didFinishFetch' emit one next event") {
                    expect(didFinishFetchObserver.events).to(haveCount(1))
                }

                describe("isLoading") {
                    it("should emit 3 events") {
                        expect(isLoadingObserver.events).to(haveCount(3))
                    }

                    it("should first event be false") {
                        expect(isLoadingObserver.events[0].value.element).to(beFalse())
                    }

                    it("should second event be true") {
                        expect(isLoadingObserver.events[1].value.element).to(beTrue())
                    }

                    it("should third event be false") {
                        expect(isLoadingObserver.events[2].value.element).to(beFalse())
                    }
                }
            }
        }
    }

}
