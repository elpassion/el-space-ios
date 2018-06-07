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
                    let fakeReport = ReportDTO.fakeReportDto(projectId: 10, value: "8.0", comment: "fake_comment", reportType: 0)
                    sut = ReportDetailsViewModel(report: fakeReport, project: nil)
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

                it("should have correct hours value") {
                    expect(sut.hours).to(equal(8.0))
                }
            }

            context("when initialize with type 0") {
                beforeEach {
                    let fakeReport = ReportDTO.fakeReportDto(projectId: 10, value: "8.0", comment: "fake_comment", reportType: 0)
                    let fakeProjectDto = ProjectDTO.fakeProjectDto(name: "fake_name", id: 10)
                    sut = ReportDetailsViewModel(report: fakeReport, project: fakeProjectDto)
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

                it("should have correct hours value") {
                    expect(sut.hours).to(equal(8.0))
                }
            }

            context("when initialize with type 1") {
                beforeEach {
                    let fakeReport = ReportDTO.fakeReportDto(projectId: nil, value: "8.0", comment: nil, reportType: 1)
                    sut = ReportDetailsViewModel(report: fakeReport, project: nil)
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

                it("should have correct hours value") {
                    expect(sut.hours).to(equal(8.0))
                }
            }

            context("when initialize with type 2") {
                beforeEach {
                    let fakeReport = ReportDTO.fakeReportDto(projectId: nil, value: "8.0", comment: nil, reportType: 2)
                    sut = ReportDetailsViewModel(report: fakeReport, project: nil)
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

                it("should have correct hours value") {
                    expect(sut.hours).to(equal(8.0))
                }
            }

            context("when initialize with type 3") {
                beforeEach {
                    let fakeReport = ReportDTO.fakeReportDto(projectId: nil, value: "8.0", comment: nil, reportType: 3)
                    sut = ReportDetailsViewModel(report: fakeReport, project: nil)
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

                it("should have correct hours value") {
                    expect(sut.hours).to(equal(8.0))
                }
            }

            context("when initialize with type 4") {
                beforeEach {
                    let fakeReport = ReportDTO.fakeReportDto(projectId: nil, value: "8.0", comment: nil, reportType: 4)
                    sut = ReportDetailsViewModel(report: fakeReport, project: nil)
                }

                it("should have correct title") {
                    expect(sut.title).to(beNil())
                }

                it("should have correct subtitle") {
                    expect(sut.subtitle).to(beNil())
                }

                it("should have correct type") {
                    expect(sut.type).to(equal(.conference))
                }

                it("should have correct hours value") {
                    expect(sut.hours).to(equal(8.0))
                }
            }

            context("when initialize with unknown type") {
                beforeEach {
                    let fakeReport = ReportDTO.fakeReportDto(projectId: nil, value: "8.0", comment: nil, reportType: 999)
                    sut = ReportDetailsViewModel(report: fakeReport, project: nil)
                }

                it("should have correct type") {
                    expect(sut.type).to(beNil())
                }

                it("should have correct hours value") {
                    expect(sut.hours).to(equal(0.0))
                }
            }
        }
    }

}
