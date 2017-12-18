import Quick
import Nimble

@testable import ELSpace

class ActivityTypeViewModelSpec: QuickSpec {

    override func spec() {
        describe("ActivityTypeViewModel") {
            var sut: ActivityTypeViewModel!

            context("time report") {
                beforeEach {
                    sut = ActivityTypeViewModel(type: .timeReport)
                }

                it("should be proper type") {
                    expect(sut.type).to(equal(ActivityType.timeReport))
                }

                it("shoud have proper title") {
                    expect(sut.title).to(equal("TIME REPORT"))
                }

                it("should have proper image for selected") {
                    expect(sut.imageSelected).to(equal(UIImage(named: "time_report_selected")))
                }

                it("should have proper image for unselected") {
                    expect(sut.imageUnselected).to(equal(UIImage(named: "time_report_unselected")))
                }
            }

            context("vacation") {
                beforeEach {
                    sut = ActivityTypeViewModel(type: .vacation)
                }

                it("should be proper type") {
                    expect(sut.type).to(equal(ActivityType.vacation))
                }

                it("shoud have proper title") {
                    expect(sut.title).to(equal("VACATION"))
                }

                it("should have proper image for selected") {
                    expect(sut.imageSelected).to(equal(UIImage(named: "vacation_selected")))
                }

                it("should have proper image for unselected") {
                    expect(sut.imageUnselected).to(equal(UIImage(named: "vacation_unselected")))
                }
            }

            context("day off") {
                beforeEach {
                    sut = ActivityTypeViewModel(type: .dayOff)
                }

                it("should be proper type") {
                    expect(sut.type).to(equal(ActivityType.dayOff))
                }

                it("shoud have proper title") {
                    expect(sut.title).to(equal("DAY OFF"))
                }

                it("should have proper image for selected") {
                    expect(sut.imageSelected).to(equal(UIImage(named: "day_off_selected")))
                }

                it("should have proper image for unselected") {
                    expect(sut.imageUnselected).to(equal(UIImage(named: "day_off_unselected")))
                }
            }

            context("sick leave") {
                beforeEach {
                    sut = ActivityTypeViewModel(type: .sickLeave)
                }

                it("should be proper type") {
                    expect(sut.type).to(equal(ActivityType.sickLeave))
                }

                it("shoud have proper title") {
                    expect(sut.title).to(equal("SICK LEAVE"))
                }

                it("should have proper image for selected") {
                    expect(sut.imageSelected).to(equal(UIImage(named: "sick_leave_selected")))
                }

                it("should have proper image for unselected") {
                    expect(sut.imageUnselected).to(equal(UIImage(named: "sick_leave_unselected")))
                }
            }

            context("conference") {
                beforeEach {
                    sut = ActivityTypeViewModel(type: .conference)
                }

                it("should be proper type") {
                    expect(sut.type).to(equal(ActivityType.conference))
                }

                it("shoud have proper title") {
                    expect(sut.title).to(equal("CONFERENCE"))
                }

                it("should have proper image for selected") {
                    expect(sut.imageSelected).to(equal(UIImage(named: "conference_selected")))
                }

                it("should have proper image for unselected") {
                    expect(sut.imageUnselected).to(equal(UIImage(named: "conference_unselected")))
                }
            }
        }
    }
}
