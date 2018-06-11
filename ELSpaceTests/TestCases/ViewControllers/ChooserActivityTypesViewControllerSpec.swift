import Quick
import Nimble
import RxSwift
import RxTest

@testable import ELSpace

class ChooserActivityTypesViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ChooserActivityTypesViewController") {
            var sut: ChooserActivityTypesViewController!
            var viewModelMock: ViewModelMock!
            var scheduler: TestScheduler!
            var typeSelectedObserver: TestableObserver<ReportType>!

            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
                typeSelectedObserver = scheduler.createObserver(ReportType.self)
                viewModelMock = ViewModelMock()
                sut = ChooserActivityTypesViewController(viewModel: viewModelMock)
                _ = sut.view
                _ = sut.selected.subscribe(typeSelectedObserver)
            }

            context("when try to initialize with init coder") {
                it("should throw fatalError") {
                    expect { sut = ChooserActivityTypesViewController(coder: NSCoder()) }.to(throwAssertion())
                }
            }

            context("when selecting time report") {
                beforeEach {
                    sut.select.onNext(ReportType.normal)
                }

                it("should select time report") {
                    expect(typeSelectedObserver.events.last?.value.element).to(equal(ReportType.normal))
                }

                context("when selecting vacation") {
                    beforeEach {
                        viewModelMock.activityTypeViewModels[1].isSelected.accept(true)
                    }

                    it("should select vacation") {
                        expect(typeSelectedObserver.events.last?.value.element).to(equal(ReportType.paidVacations))
                    }
                }
            }
        }
    }
}

private struct ViewModelMock: ChooserActivityTypesViewModeling {

    var activityTypeViewModels: [ActivityTypeViewModeling] = [ActivityTypeViewModel(type: .normal),
                                                              ActivityTypeViewModel(type: .paidVacations)]

}
