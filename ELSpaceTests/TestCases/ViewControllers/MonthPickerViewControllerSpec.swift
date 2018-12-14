import Quick
import Nimble
import RxTest
import NTMonthYearPicker

@testable import ELSpace

class MonthPickerViewControllerSpec: QuickSpec {

    override func spec() {
        describe("MonthPickerViewController") {
            var sut: MonthPickerViewController!
            var raportDateProvider: RaportDateProviderMock!
            var scheduler: TestScheduler!
            var dismissObserver: TestableObserver<Void>!
            var bottomMenuView: BottomMenuView! {
                return sut.view as? BottomMenuView
            }
            var monthPicker: NTMonthYearPicker? {
                return bottomMenuView.items.first as? NTMonthYearPicker
            }

            beforeEach {
                raportDateProvider = RaportDateProviderMock()
                scheduler = TestScheduler(initialClock: 0)
                dismissObserver = scheduler.createObserver(Void.self)
                sut = MonthPickerViewController(raportDateProvider: raportDateProvider)
                _ = sut.dismiss.drive(dismissObserver)
            }

            context("when view did load") {
                beforeEach {
                    _ = sut.view
                }

                it("should set correct title") {
                    expect(bottomMenuView.headerView.title) == "Change month"
                }

                it("should set correct button title") {
                    expect(bottomMenuView.headerView.doneButtonTitle) == "Apply"
                }

                it("should set correct items") {
                    expect(bottomMenuView.items.count) == 1
                    expect(monthPicker).notTo(beNil())
                }

                it("should set correct initial date") {
                    expect(monthPicker?.date) == Date.init(timeIntervalSince1970: 0)
                }

                it("should set correct min date") {
                    expect(monthPicker?.minimumDate) == Date.distantPast
                }

                it("should set correct max date") {
                    expect(monthPicker?.maximumDate) == Date.distantFuture
                }

                context("when tapping on background view") {
                    beforeEach {
                        bottomMenuView.backgroundView.sendActions(for: .touchUpInside)
                    }

                    it("should emit correct event") {
                        expect(dismissObserver.events.count) == 1
                    }
                }

                context("when done button action") {
                    beforeEach {
                        monthPicker?.date = Date.init(timeIntervalSince1970: 999)
                        bottomMenuView.headerView.doneButton.sendActions(for: .touchUpInside)
                    }

                    it("should correctly update raport provider") {
                        expect(raportDateProvider.currentRaportDate.value) == Date.init(timeIntervalSince1970: 999)
                    }

                    it("should emit correct event") {
                        expect(dismissObserver.events.count) == 1
                    }
                }
            }
        }
    }
}
