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
                reportsServiceStub.result = reportsResultFake
                projectsServiceStub = ProjectsServiceStub()
                projectsServiceStub.result = projectsResultFake
                sut = ActivitiesController(reportsService: reportsServiceStub,
                                           projectsService: projectsServiceStub)
                _ = sut.reports.subscribe(reportObserver)
                _ = sut.projects.subscribe(projectObserver)
                _ = sut.didFinishFetch.subscribe(didFinishFetchObserver)
                _ = sut.isLoading.subscribe(isLoadingObserver)
            }

            afterEach {
                sut = nil
                reportsServiceStub = nil
                projectsServiceStub = nil
                reportsResultFake = nil
                projectsResultFake = nil
                reportObserver = nil
                projectObserver = nil
                didFinishFetchObserver = nil
                isLoadingObserver = nil
                scheduler = nil
            }

            context("when fetch reports") {
                beforeEach {
                    sut.getReports(from: "", to: "")
                }

                it("should 'reports' emit one next event") {
                    expect(reportObserver.events).to(haveCount(1))
                }

                it("should 'projects' NOT emit any event") {
                    expect(projectObserver.events).to(haveCount(0))
                }

                it("should 'didFinishFetch' NOT emit any event") {
                    expect(didFinishFetchObserver.events).to(haveCount(0))
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

            context("when fetch projects") {
                beforeEach {
                    sut.getProjects()
                }

                it("should 'reports' NOT emit any event") {
                    expect(reportObserver.events).to(haveCount(0))
                }

                it("should 'projects' emit one next event") {
                    expect(projectObserver.events).to(haveCount(1))
                }

                it("should 'didFinishFetch' NOT emit any event") {
                    expect(didFinishFetchObserver.events).to(haveCount(0))
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

            context("when fetch reports and projects") {
                beforeEach {
                    sut.getReports(from: "", to: "")
                    sut.getProjects()
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
                    it("should emit 5 events") {
                        expect(isLoadingObserver.events).to(haveCount(5))
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

                    it("should second event be true") {
                        expect(isLoadingObserver.events[3].value.element).to(beTrue())
                    }

                    it("should third event be false") {
                        expect(isLoadingObserver.events[4].value.element).to(beFalse())
                    }
                }
            }
        }
    }

}
