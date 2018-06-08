import Quick
import Nimble
import RxTest
import RxCocoa

@testable import ELSpace

class ChooserActivityTypesViewModelSpec: QuickSpec {

    override func spec() {
        describe("ChooserActivityTypesViewModel") {
            var sut: ChooserActivityTypesViewModel!

            beforeEach {
                let report = ReportDTO(id: 1,
                                       userId: 2,
                                       projectId: 3,
                                       value: "4",
                                       performedAt: "5",
                                       comment: "6",
                                       createdAt: "7",
                                       updatedAt: "8",
                                       billable: true,
                                       reportType: 1)
                sut = ChooserActivityTypesViewModel(report: report)
            }

            it("should return 5 report types") {
                expect(sut.activityTypeViewModels).to(haveCount(5))
            }

            describe("types and order") {
                it("should have first time report") {
                    let viewModel = sut.activityTypeViewModels[0] as! ActivityTypeViewModel
                    expect(viewModel).to(equal(ActivityTypeViewModel(type: .normal)))
                }

                it("should have second time report") {
                    let viewModel = sut.activityTypeViewModels[1] as! ActivityTypeViewModel
                    expect(viewModel).to(equal(ActivityTypeViewModel(type: .paidVacations)))
                }

                it("should have third time report") {
                    let viewModel = sut.activityTypeViewModels[2] as! ActivityTypeViewModel
                    expect(viewModel).to(equal(ActivityTypeViewModel(type: .unpaidDayOff)))
                }

                it("should have fourth time report") {
                    let viewModel = sut.activityTypeViewModels[3] as! ActivityTypeViewModel
                    expect(viewModel).to(equal(ActivityTypeViewModel(type: .sickLeave)))
                }

                it("should have fifth time report") {
                    let viewModel = sut.activityTypeViewModels[4] as! ActivityTypeViewModel
                    expect(viewModel).to(equal(ActivityTypeViewModel(type: .conference)))
                }

                it("should paid vacations be selected") {
                    expect(sut.activityTypeViewModels[1].isSelected.value).to(beTrue())
                }
            }

            describe("switching types") {
                var scheduler: TestScheduler!
                var isTimeReportSelectedObserver: TestableObserver<Bool>!
                var isVacationSelectedObserver: TestableObserver<Bool>!
                var isDayOffSelectedObserver: TestableObserver<Bool>!
                var isSickLeaveSelectedObserver: TestableObserver<Bool>!
                var isConferenceSelectedObserver: TestableObserver<Bool>!

                beforeEach {
                    scheduler = TestScheduler(initialClock: 0)
                    isTimeReportSelectedObserver = scheduler.createObserver(Bool.self)
                    isVacationSelectedObserver = scheduler.createObserver(Bool.self)
                    isDayOffSelectedObserver = scheduler.createObserver(Bool.self)
                    isSickLeaveSelectedObserver = scheduler.createObserver(Bool.self)
                    isConferenceSelectedObserver = scheduler.createObserver(Bool.self)
                    _ = sut.activityTypeViewModels[0].isSelected.asObservable().subscribe(isTimeReportSelectedObserver)
                    _ = sut.activityTypeViewModels[1].isSelected.asObservable().subscribe(isVacationSelectedObserver)
                    _ = sut.activityTypeViewModels[2].isSelected.asObservable().subscribe(isDayOffSelectedObserver)
                    _ = sut.activityTypeViewModels[3].isSelected.asObservable().subscribe(isSickLeaveSelectedObserver)
                    _ = sut.activityTypeViewModels[4].isSelected.asObservable().subscribe(isConferenceSelectedObserver)
                }

                context("when selecting time report") {
                    beforeEach {
                        sut.activityTypeViewModels[0].isSelected.accept(true)
                    }

                    it("should properly update time report state") {
                        expect(isTimeReportSelectedObserver.events.last?.value.element).to(beTrue())
                    }

                    it("should properly update vacation state") {
                        expect(isVacationSelectedObserver.events.last?.value.element).to(beFalse())
                    }

                    it("should properly update day off state") {
                        expect(isDayOffSelectedObserver.events.last?.value.element).to(beFalse())
                    }

                    it("should properly update sick leave state") {
                        expect(isSickLeaveSelectedObserver.events.last?.value.element).to(beFalse())
                    }

                    it("should properly update conference state") {
                        expect(isConferenceSelectedObserver.events.last?.value.element).to(beFalse())
                    }

                    context("when selecting vacation") {
                        beforeEach {
                            sut.activityTypeViewModels[1].isSelected.accept(true)
                        }

                        it("should properly update time report state") {
                            expect(isTimeReportSelectedObserver.events.last?.value.element).to(beFalse())
                        }

                        it("should properly update vacation state") {
                            expect(isVacationSelectedObserver.events.last?.value.element).to(beTrue())
                        }

                        it("should properly update day off state") {
                            expect(isDayOffSelectedObserver.events.last?.value.element).to(beFalse())
                        }

                        it("should properly update sick leave state") {
                            expect(isSickLeaveSelectedObserver.events.last?.value.element).to(beFalse())
                        }

                        it("should properly update conference state") {
                            expect(isConferenceSelectedObserver.events.last?.value.element).to(beFalse())
                        }
                    }
                }
            }
        }
    }
}

extension ActivityTypeViewModel: Equatable {

    public static func == (lhs: ActivityTypeViewModel, rhs: ActivityTypeViewModel) -> Bool {
        return lhs.type == rhs.type
    }

}
