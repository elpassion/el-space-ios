import Quick
import Nimble

@testable import ELSpace

class AppContainer_ViewModelsSpec: QuickSpec {

    override func spec() {
        describe("AppContainer_ViewModels") {
            var sut: AppContainer!

            beforeEach {
                sut = AppContainer()
            }

            it("should build ActivitiesViewModel") {
                expect(sut.activitiesViewModel()).to(beAnInstanceOf(ActivitiesViewModel.self))
            }

            it("should build ActivityViewModel") {
                expect(sut.activityViewModel(activityType: .new(Date()), projectScope: []))
                    .to(beAnInstanceOf(ActivityViewModel.self))
            }

            it("should build ProjectSearchViewModel") {
                expect(sut.projectSearchViewModel(projectId: nil))
                    .to(beAnInstanceOf(ProjectSearchViewModel.self))
            }
        }
    }
}
