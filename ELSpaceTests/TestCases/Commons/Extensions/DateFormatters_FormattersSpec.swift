import Quick
import Nimble

@testable import ELSpace

class DateFormatters_FormattersSpec: QuickSpec {

    override func spec() {
        describe("DateFormatters_Formatters") {
            var sut: DateFormatter!

            describe("shortDateFormatter") {
                beforeEach {
                    sut = DateFormatter.shortDateFormatter
                }

                it("should return correct date formatter") {
                    expect(sut.locale) == Locale(identifier: "en")
                    expect(sut.timeZone) == TimeZone(identifier: "Europe/Warsaw")
                    expect(sut.dateFormat) == "yyyy-MM-dd"
                }
            }

            describe("dayFormatter") {
                beforeEach {
                    sut = DateFormatter.dayFormatter
                }

                it("should return correct date formatter") {
                    expect(sut.locale) == Locale(identifier: "en")
                    expect(sut.timeZone) == TimeZone(identifier: "Europe/Warsaw")
                    expect(sut.dateFormat) == "d E"
                }
            }

            describe("monthFormatter") {
                beforeEach {
                    sut = DateFormatter.monthFormatter
                }

                it("should return correct date formatter") {
                    expect(sut.locale) == Locale(identifier: "en")
                    expect(sut.timeZone) == TimeZone(identifier: "Europe/Warsaw")
                    expect(sut.dateFormat) == "MMMM yyyy"
                }
            }

            describe("activityFormatter") {
                beforeEach {
                    sut = DateFormatter.activityFormatter
                }

                it("should return correct date formatter") {
                    expect(sut.locale) == Locale(identifier: "en")
                    expect(sut.timeZone) == TimeZone(identifier: "Europe/Warsaw")
                    expect(sut.dateFormat) == "E, d MMM yyyy"
                }
            }
        }
    }
}
