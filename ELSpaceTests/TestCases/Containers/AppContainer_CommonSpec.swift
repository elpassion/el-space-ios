import Quick
import Nimble

@testable import ELSpace

class AppContainer_CommonSpec: QuickSpec {

    override func spec() {
        describe("AppContainer_Common") {
            var sut: AppContainer!

            beforeEach {
                sut = AppContainer()
            }

            it("should build SelectionControllerSignIn") {
                expect(sut.selectionController(googleIdToken: "")).to(beAnInstanceOf(SelectionController.self))
            }

            it("should build ActivitiesController") {
                expect(sut.activitiesController).to(beAnInstanceOf(ActivitiesController.self))
            }

            it("should build ProjectSearchController") {
                expect(sut.projectSearchController).to(beAnInstanceOf(ProjectSearchController.self))
            }

            it("should build GoogleUserMapper") {
                expect(sut.googleUserMapper).to(beAnInstanceOf(GoogleUserMapper.self))
            }

            it("should build SelectionScreenPresenter") {
                expect(sut.selectionScreenPresenter(presenterViewController: UIViewController()))
                    .to(beAnInstanceOf(SelectionScreenPresenter.self))
            }
        }
    }
}
