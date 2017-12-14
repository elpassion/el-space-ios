import Quick
import Nimble
import RxTest

@testable import ELSpace

class ChooserActivityTypesViewModelSpec: QuickSpec {

    override func spec() {
        describe("ChooserActivityTypesViewModel") {
            var sut: ChooserActivityTypesViewModel!

            beforeEach {
                sut = ChooserActivityTypesViewModel()
            }

            it("should return 5 report types") {
                expect(sut.activityTypeViewModels).to(haveCount(5))
            }

            describe("types and order") {
                it("should have first time report") {
                    let viewModel = sut.activityTypeViewModels[0] as! ActivityTypeViewModel
                    expect(viewModel).to(equal(ActivityTypeViewModel(type: .timeReport)))
                }

                it("should have second time report") {
                    let viewModel = sut.activityTypeViewModels[1] as! ActivityTypeViewModel
                    expect(viewModel).to(equal(ActivityTypeViewModel(type: .vacation)))
                }

                it("should have third time report") {
                    let viewModel = sut.activityTypeViewModels[2] as! ActivityTypeViewModel
                    expect(viewModel).to(equal(ActivityTypeViewModel(type: .dayOff)))
                }

                it("should have fourth time report") {
                    let viewModel = sut.activityTypeViewModels[3] as! ActivityTypeViewModel
                    expect(viewModel).to(equal(ActivityTypeViewModel(type: .sickLeave)))
                }

                it("should have fifth time report") {
                    let viewModel = sut.activityTypeViewModels[4] as! ActivityTypeViewModel
                    expect(viewModel).to(equal(ActivityTypeViewModel(type: .conference)))
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
                        sut.activityTypeViewModels[0].isSelected.onNext(true)
                    }

                    it("should properly update state") {
                        expect(isTimeReportSelectedObserver.events.last?.value.element).to(beTrue())
                        expect(isVacationSelectedObserver.events.last).to(beNil())
                        expect(isDayOffSelectedObserver.events.last).to(beNil())
                        expect(isSickLeaveSelectedObserver.events.last).to(beNil())
                        expect(isConferenceSelectedObserver.events.last).to(beNil())
                    }

                    context("when selecting vacation") {
                        beforeEach {
                            sut.activityTypeViewModels[1].isSelected.onNext(true)
                        }

                        it("should properly update state") {
                            expect(isTimeReportSelectedObserver.events.last?.value.element).to(beFalse())
                            expect(isVacationSelectedObserver.events.last?.value.element).to(beTrue())
                            expect(isDayOffSelectedObserver.events.last).to(beNil())
                            expect(isSickLeaveSelectedObserver.events.last).to(beNil())
                            expect(isConferenceSelectedObserver.events.last).to(beNil())
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
