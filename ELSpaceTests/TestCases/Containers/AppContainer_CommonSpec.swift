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

            it("should return SelectionControllerSignIn") {
                expect(sut.selectionController(googleIdToken: "")).to(beAnInstanceOf(SelectionController.self))
            }

            it("should return ActivitiesController") {
                expect(sut.activitiesController).to(beAnInstanceOf(ActivitiesController.self))
            }

            it("should return ProjectSearchController") {
                expect(sut.projectSearchController).to(beAnInstanceOf(ProjectSearchController.self))
            }

            it("should return GoogleUserMapper") {
                expect(sut.googleUserMapper).to(beAnInstanceOf(GoogleUserMapper.self))
            }

            it("should return SelectionScreenPresenter") {
                expect(sut.selectionScreenPresenter(presenterViewController: UIViewController()))
                    .to(beAnInstanceOf(SelectionScreenPresenter.self))
            }
        }
    }
}
