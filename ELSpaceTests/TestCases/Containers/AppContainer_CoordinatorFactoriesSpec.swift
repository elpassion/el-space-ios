import Quick
import Nimble

@testable import ELSpace

class AppContainer_CoordinatorFactoriesSpec: QuickSpec {

    override func spec() {
        describe("AppContainer_CoordinatorFactories") {
            var sut: AppContainer!

            beforeEach {
                sut = AppContainer()
            }

            it("should build SelectionCoordinator") {
                expect(sut.selectionCoordinator(googleIdToken: "")).to(beAnInstanceOf(SelectionCoordinator.self))
            }

            it("should build ActivitiesCoordinator") {
                expect(sut.activitiesCoordinator()).to(beAnInstanceOf(ActivitiesCoordinator.self))
            }

            it("should build ActivityCoordinator") {
                expect(sut.activityCoordinator(activityType: .new(Date()), projectScope: []))
                    .to(beAnInstanceOf(ActivityCoordinator.self))
            }

            it("should build ProjectSearchCoordinator") {
                expect(sut.projectSearchCoordinator(projectId: 1)).to(beAnInstanceOf(ProjectSearchCoordinator.self))
            }
        }
    }
}
