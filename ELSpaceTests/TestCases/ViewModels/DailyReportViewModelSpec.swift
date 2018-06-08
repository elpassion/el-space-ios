import Quick
import Nimble
import SwiftDate

@testable import ELSpace

class DailyReportViewModelSpec: QuickSpec {

    override func spec() {
        describe("DailyReportViewModel") {

            var sut: DailyReportViewModel!
            var formatter: DateFormatter!

            beforeEach {
                formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm"
            }

            afterEach {
                sut = nil
                formatter = nil
            }

            context("when initialize with 2 normal weekday reports") {
                var dateFake: Date!

                beforeEach {
                    dateFake = formatter.date(from: "2017/08/09 22:31")
                    let fakeReports: [ReportDTO] = [
                        ReportDTO.fakeReportDto(projectId: 10, value: "3.0", performedAt: "2017/08/09 22:31", comment: "fake_comment1", reportType: 0),
                        ReportDTO.fakeReportDto(projectId: 11, value: "5.0", performedAt: "2017/08/09 22:31", comment: "fake_comment2", reportType: 0)
                    ]
                    let fakeProjectsDTO = [
                        ProjectDTO.fakeProjectDto(name: "fake_name1", id: 10),
                        ProjectDTO.fakeProjectDto(name: "fake_name2", id: 11)
                    ]
                    sut = DailyReportViewModel(date: dateFake, todayDate: dateFake, reports: fakeReports, projects: fakeProjectsDTO, isHoliday: false)
                }

                it("should have correct title") {
                    expect(sut.title?.string).to(equal("Total: 8.0 hours"))
                }

                it("should have correct day") {
                    expect(sut.day.string).to(equal(DateFormatter.dayFormatter.string(from: dateFake)))
                }

                it("should have correct dayType") {
                    expect(sut.dayType).to(equal(DayType.weekday))
                }

                it("should have correct stripeColor") {
                    expect(sut.stripeColor).to(equal(UIColor(color: .green92ECB4)))
                }

                it("should have correct backgroundColor") {
                    expect(sut.backgroundColor).to(equal(UIColor.white))
                }

                it("should have correct hideAddReportButton value") {
                    expect(sut.hideAddReportButton).to(beFalse())
                }

                describe("ReportsViewModel") {
                    var reportsViewModel: [ReportDetailsViewModelProtocol]!

                    beforeEach {
                        reportsViewModel = sut.reportsViewModel
                    }

                    it("should have 2 elements") {
                        expect(reportsViewModel).to(haveCount(2))
                    }
                }
            }

            context("when initialize with weekday report with type 1") {
                var dateFake: Date!

                beforeEach {
                    dateFake = formatter.date(from: "2017/08/09 22:31")
                    let fakeReports: [ReportDTO] = [
                        ReportDTO.fakeReportDto(projectId: nil, value: "8.0", performedAt: "2017/08/09 22:31", comment: nil, reportType: 1)
                    ]
                    let fakeProjectsDTO = [
                        ProjectDTO.fakeProjectDto(name: "fake_name1", id: 10),
                        ProjectDTO.fakeProjectDto(name: "fake_name2", id: 11)
                    ]
                    sut = DailyReportViewModel(date: dateFake, todayDate: dateFake, reports: fakeReports, projects: fakeProjectsDTO, isHoliday: false)
                }

                it("should have correct title") {
                    expect(sut.title?.string).to(equal("Total: 8.0 hours"))
                }

                it("should have correct dayType") {
                    expect(sut.dayType).to(equal(DayType.weekday))
                }

                it("should have correct hideAddReportButton value") {
                    expect(sut.hideAddReportButton).to(beFalse())
                }
            }

            context("when initialize with weekday report with type 2") {
                var dateFake: Date!

                beforeEach {
                    dateFake = formatter.date(from: "2017/08/09 22:31")
                    let fakeReports: [ReportDTO] = [
                        ReportDTO.fakeReportDto(projectId: nil, value: "8.0", performedAt: "2017/08/09 22:31", comment: nil, reportType: 2)
                    ]
                    let fakeProjectsDTO = [
                        ProjectDTO.fakeProjectDto(name: "fake_name1", id: 10),
                        ProjectDTO.fakeProjectDto(name: "fake_name2", id: 11)
                    ]
                    sut = DailyReportViewModel(date: dateFake, todayDate: dateFake, reports: fakeReports, projects: fakeProjectsDTO, isHoliday: false)
                }

                it("should have correct title") {
                    expect(sut.title?.string).to(equal("Unpaid vacations"))
                }

                it("should have correct dayType") {
                    expect(sut.dayType).to(equal(DayType.weekday))
                }

                it("should have correct hideAddReportButton value") {
                    expect(sut.hideAddReportButton).to(beTrue())
                }
            }

            context("when initialize with weekday report with type 3") {
                var dateFake: Date!

                beforeEach {
                    dateFake = formatter.date(from: "2017/08/09 22:31")
                    let fakeReports: [ReportDTO] = [
                        ReportDTO.fakeReportDto(projectId: nil, value: "8.0", performedAt: "2017/08/09 22:31", comment: nil, reportType: 3)
                    ]
                    let fakeProjectsDTO = [
                        ProjectDTO.fakeProjectDto(name: "fake_name1", id: 10),
                        ProjectDTO.fakeProjectDto(name: "fake_name2", id: 11)
                    ]
                    sut = DailyReportViewModel(date: dateFake, todayDate: dateFake, reports: fakeReports, projects: fakeProjectsDTO, isHoliday: false)
                }

                it("should have correct title") {
                    expect(sut.title?.string).to(equal("Sick leave"))
                }

                it("should have correct dayType") {
                    expect(sut.dayType).to(equal(DayType.weekday))
                }

                it("should have correct hideAddReportButton value") {
                    expect(sut.hideAddReportButton).to(beTrue())
                }
            }

            context("when initialize with weekday report with type 3") {
                var dateFake: Date!

                beforeEach {
                    dateFake = formatter.date(from: "2017/08/09 22:31")
                    let fakeReports: [ReportDTO] = [
                        ReportDTO.fakeReportDto(projectId: nil, value: "8.0", performedAt: "2017/08/09 22:31", comment: nil, reportType: 4)
                    ]
                    sut = DailyReportViewModel(date: dateFake, todayDate: dateFake, reports: fakeReports, projects: [], isHoliday: false)
                }

                it("should have correct title") {
                    expect(sut.title?.string).to(equal("Conference"))
                }

                it("should have correct dayType") {
                    expect(sut.dayType).to(equal(DayType.weekday))
                }

                it("should have correct hideAddReportButton value") {
                    expect(sut.hideAddReportButton).to(beTrue())
                }
            }

            context("when initialize with weekend date") {
                var dateFake: Date!

                beforeEach {
                    dateFake = formatter.date(from: "2017/08/12 22:31")
                    sut = DailyReportViewModel(date: dateFake, todayDate: dateFake, reports: [], projects: [], isHoliday: false)
                }

                it("should have correct title") {
                    expect(sut.title?.string).to(equal("Weekend!"))
                }

                it("should have correct day") {
                    expect(sut.day.string).to(equal(DateFormatter.dayFormatter.string(from: dateFake)))
                }

                it("should have correct dayType") {
                    expect(sut.dayType).to(equal(DayType.weekend))
                }

                it("should have correct stripeColor") {
                    expect(sut.stripeColor).to(equal(UIColor.clear))
                }

                it("should have correct backgroundColor") {
                    expect(sut.backgroundColor).to(equal(UIColor.clear))
                }

                describe("ReportsViewModel") {
                    var reportsViewModel: [ReportDetailsViewModelProtocol]!

                    beforeEach {
                        reportsViewModel = sut.reportsViewModel
                    }

                    it("should have 0 elements") {
                        expect(reportsViewModel).to(haveCount(0))
                    }
                }
            }

            context("when initialize with comming date") {
                var dateFake: Date!

                beforeEach {
                    var date = Date() + 1.day
                    while date.isInWeekend == true {
                        date = date + 1.day // swiftlint:disable:this shorthand_operator
                    }
                    dateFake = date
                    sut = DailyReportViewModel(date: dateFake, todayDate: dateFake, reports: [], projects: [], isHoliday: false)
                }

                it("should have correct title") {
                    expect(sut.title).to(beNil())
                }

                it("should have correct day") {
                    expect(sut.day.string).to(equal(DateFormatter.dayFormatter.string(from: dateFake)))
                }

                it("should have correct dayType") {
                    expect(sut.dayType).to(equal(DayType.comming))
                }

                it("should have correct stripeColor") {
                    expect(sut.stripeColor).to(equal(UIColor(color: .grayE4E4E4)))
                }

                it("should have correct backgroundColor") {
                    expect(sut.backgroundColor).to(equal(UIColor.white))
                }

                describe("ReportsViewModel") {
                    var reportsViewModel: [ReportDetailsViewModelProtocol]!

                    beforeEach {
                        reportsViewModel = sut.reportsViewModel
                    }

                    it("should have 0 elements") {
                        expect(reportsViewModel).to(haveCount(0))
                    }
                }
            }

            context("when initialize with previous Date and empty reports") {
                var dateFake: Date!

                beforeEach {
                    var date = Date() - 1.day
                    while date.isInWeekend == true {
                        date = date - 1.day // swiftlint:disable:this shorthand_operator
                    }
                    dateFake = date
                    sut = DailyReportViewModel(date: dateFake, todayDate: Date(), reports: [], projects: [], isHoliday: false)
                }

                it("should have correct title") {
                    expect(sut.title?.string).to(equal("Missing"))
                }

                it("should have correct day") {
                    expect(sut.day.string).to(equal(DateFormatter.dayFormatter.string(from: dateFake)))
                }

                it("should have correct dayType") {
                    expect(sut.dayType).to(equal(DayType.missing))
                }

                it("should have correct stripeColor") {
                    expect(sut.stripeColor).to(equal(UIColor(color: .redBA6767)))
                }

                it("should have correct backgroundColor") {
                    expect(sut.backgroundColor).to(equal(UIColor.white))
                }

                describe("ReportsViewModel") {
                    var reportsViewModel: [ReportDetailsViewModelProtocol]!

                    beforeEach {
                        reportsViewModel = sut.reportsViewModel
                    }

                    it("should have 0 elements") {
                        expect(reportsViewModel).to(haveCount(0))
                    }
                }
            }

            context("when day isHoliday") {
                beforeEach {
                    sut = DailyReportViewModel(date: Date(), todayDate: Date(), reports: [], projects: [], isHoliday: true)
                }

                it("should have correct title") {
                    expect(sut.title?.string).to(equal("Holiday"))
                }

                it("should have correct dayType") {
                    expect(sut.dayType).to(equal(DayType.holiday))
                }

                it("should have correct stripeColor") {
                    expect(sut.stripeColor).to(equal(UIColor.clear))
                }

                it("should have correct backgroundColor") {
                    expect(sut.backgroundColor).to(equal(UIColor.clear))
                }
            }
        }
    }

}
