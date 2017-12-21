import Quick
import Nimble

@testable import ELSpace

class ReportDetailsViewModelSpec: QuickSpec {

    override func spec() {
        describe("ReportDetailsViewModel") {

            var sut: ReportDetailsViewModel!

            afterEach {
                sut = nil
            }

            context("when initialize with type 0 and nil project") {
                beforeEach {
                    let fakeReportViewModel = ReportViewModelFake(projectId: 10,
                                                                  date: Date(),
                                                                  value: 8.0,
                                                                  comment: "fake_comment",
                                                                  type: 0)
                    sut = ReportDetailsViewModel(report: fakeReportViewModel, project: nil)
                }

                it("should have correct title") {
                    expect(sut.title).to(equal("8.0"))
                }

                it("should have correct subtitle") {
                    expect(sut.subtitle).to(equal("fake_comment"))
                }

                it("should have correct type") {
                    expect(sut.type).to(equal(.normal))
                }

                it("should have correct value") {
                    expect(sut.value).to(equal(8.0))
                }
            }

            context("when initialize with type 0") {
                beforeEach {
                    let fakeReportViewModel = ReportViewModelFake(projectId: 10,
                                                                  date: Date(),
                                                                  value: 8.0,
                                                                  comment: "fake_comment",
                                                                  type: 0)
                    let fakeProjectDto = ProjectDTO.fakeProjectDto(name: "fake_name", id: 10)
                    sut = ReportDetailsViewModel(report: fakeReportViewModel, project: fakeProjectDto)
                }

                it("should have correct title") {
                    expect(sut.title).to(equal("fake_name - 8.0"))
                }

                it("should have correct subtitle") {
                    expect(sut.subtitle).to(equal("fake_comment"))
                }

                it("should have correct type") {
                    expect(sut.type).to(equal(.normal))
                }

                it("should have correct value") {
                    expect(sut.value).to(equal(8.0))
                }
            }

            context("when initialize with type 1") {
                beforeEach {
                    let fakeReportViewModel = ReportViewModelFake(projectId: nil,
                                                                  date: Date(),
                                                                  value: 8.0,
                                                                  comment: nil,
                                                                  type: 1)
                    sut = ReportDetailsViewModel(report: fakeReportViewModel, project: nil)
                }

                it("should have correct title") {
                    expect(sut.title).to(equal("Vacations"))
                }

                it("should have correct subtitle") {
                    expect(sut.subtitle).to(beNil())
                }

                it("should have correct type") {
                    expect(sut.type).to(equal(.paidVacations))
                }

                it("should have correct value") {
                    expect(sut.value).to(equal(8.0))
                }
            }

            context("when initialize with type 2") {
                beforeEach {
                    let fakeReportViewModel = ReportViewModelFake(projectId: nil,
                                                                  date: Date(),
                                                                  value: 8.0,
                                                                  comment: nil,
                                                                  type: 2)
                    sut = ReportDetailsViewModel(report: fakeReportViewModel, project: nil)
                }

                it("should have correct title") {
                    expect(sut.title).to(beNil())
                }

                it("should have correct subtitle") {
                    expect(sut.subtitle).to(beNil())
                }

                it("should have correct type") {
                    expect(sut.type).to(equal(.unpaidDayOff))
                }

                it("should have correct value") {
                    expect(sut.value).to(equal(8.0))
                }
            }

            context("when initialize with type 3") {
                beforeEach {
                    let fakeReportViewModel = ReportViewModelFake(projectId: nil,
                                                                  date: Date(),
                                                                  value: 8.0,
                                                                  comment: nil,
                                                                  type: 3)
                    sut = ReportDetailsViewModel(report: fakeReportViewModel, project: nil)
                }

                it("should have correct title") {
                    expect(sut.title).to(beNil())
                }

                it("should have correct subtitle") {
                    expect(sut.subtitle).to(beNil())
                }

                it("should have correct type") {
                    expect(sut.type).to(equal(.sickLeave))
                }

                it("should have correct value") {
                    expect(sut.value).to(equal(8.0))
                }
            }

            context("when initialize with unknown type") {
                beforeEach {
                    let fakeReportViewModel = ReportViewModelFake(projectId: nil,
                                                                  date: Date(),
                                                                  value: 8.0,
                                                                  comment: nil,
                                                                  type: 999)
                    sut = ReportDetailsViewModel(report: fakeReportViewModel, project: nil)
                }

                it("should have correct type") {
                    expect(sut.type).to(beNil())
                }

                it("should have correct value") {
                    expect(sut.value).to(equal(0.0))
                }
            }
        }
    }

}
