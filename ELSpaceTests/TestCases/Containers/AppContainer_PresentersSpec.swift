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

            it("should build ViewControllerPresenter") {
                expect(sut.viewControllerPresenter)
                    .to(beAnInstanceOf(ViewControllerPresenter.self))
            }

            it("should build ModalViewControllerPresenter") {
                expect(sut.modalViewControllerPresenter)
                    .to(beAnInstanceOf(ModalViewControllerPresenter.self))
            }

            it("should build basicModalPresentationConfiguration") {
                let configuration = sut.basicModalPresentationConfiguration

                expect(configuration.animated) == true
                expect(configuration.presentTransition).to(beAnInstanceOf(ModalViewControllerPresentTransition.self))
                expect(configuration.dismissTransition).to(beAnInstanceOf(ModalViewControllerDismissTransition.self))
                expect(configuration.presentationStyle) == .overFullScreen
            }
        }
    }
}
