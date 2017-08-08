import Quick
import Nimble

@testable import ELSpace

class ReportViewModelSpec: QuickSpec {

    override func spec() {
        describe("ReportViewModel") {

            var sut: ReportViewModel!

            describe("date") {
                context("when initialize with correct performedAt date") {
                    var formatter: DateFormatter!

                    beforeEach {
                        formatter = DateFormatter.shortDateFormatter
                        let fakeReportDto = ReportDTO.fakeReportDto(performedAt: "2017-08-01")
                        sut = ReportViewModel(report: fakeReportDto)
                    }

                    it("should have correct value") {
                        expect(sut.date).to(equal(formatter.date(from: "2017-08-01")!))
                    }
                }

                context("when initialize with uncorrect performedAt date") {
                    beforeEach {
                        let fakeReportDto = ReportDTO.fakeReportDto(performedAt: "2017-08-02T12:07:52.752+02:00")
                        sut = ReportViewModel(report: fakeReportDto)
                    }

                    it("should throw fatalError") {
                        expect { _ = sut.date }.to(throwAssertion())
                    }
                }
            }

            describe("value") {
                context("when initialize with correct value") {
                    beforeEach {
                        let fakeReportDto = ReportDTO.fakeReportDto(value: "8.0")
                        sut = ReportViewModel(report: fakeReportDto)
                    }

                    it("should have correct value") {
                        expect(sut.value).to(equal(8.0))
                    }
                }
                context("when initialize with uncorrect value") {
                    beforeEach {
                        let fakeReportDto = ReportDTO.fakeReportDto(value: "wrong_value")
                        sut = ReportViewModel(report: fakeReportDto)
                    }

                    it("should return correct value") {
                        expect(sut.value).to(equal(0.0))
                    }
                }
            }

            describe("projectId") {
                beforeEach {
                    let fakeReportDto = ReportDTO.fakeReportDto(projectId: 0)
                    sut = ReportViewModel(report: fakeReportDto)
                }

                it("should have correct value") {
                    expect(sut.projectId).to(equal(0))
                }
            }

            describe("comment") {
                beforeEach {
                    let fakeReportDto = ReportDTO.fakeReportDto(comment: "fake_comment")
                    sut = ReportViewModel(report: fakeReportDto)
                }

                it("should have correct value") {
                    expect(sut.comment).to(equal("fake_comment"))
                }
            }

            describe("type") {
                beforeEach {
                    let fakeReportDto = ReportDTO.fakeReportDto(reportType: 0)
                    sut = ReportViewModel(report: fakeReportDto)
                }

                it("should have correct value") {
                    expect(sut.type).to(equal(0))
                }
            }
        }
    }

}
