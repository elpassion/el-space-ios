import Quick
import Nimble

@testable import ELSpace

class AppContainer_PresentersSpec: QuickSpec {

    override func spec() {
        describe("AppContainer_Presenters") {
            var sut: AppContainer!

            beforeEach {
                sut = AppContainer()
            }

            it("should return ViewControllerPresenter") {
                expect(sut.viewControllerPresenter).to(beAnInstanceOf(ViewControllerPresenter.self))
            }

            it("should return ModalViewControllerPresenter") {
                expect(sut.modalViewControllerPresenter).to(beAnInstanceOf(ModalViewControllerPresenter.self))
            }
        }
    }
}
