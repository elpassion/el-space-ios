import Quick
import Nimble

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
        }
    }
}

extension ActivityTypeViewModel: Equatable {

    public static func == (lhs: ActivityTypeViewModel, rhs: ActivityTypeViewModel) -> Bool {
        return lhs.type == rhs.type
    }

}
