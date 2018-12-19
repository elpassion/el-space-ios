import Quick
import Nimble

@testable import ELSpace

class AppContainer_ViewControllersSpec: QuickSpec {

    override func spec() {
        describe("AppContainer_ViewControllers") {
            var sut: AppContainer!

            beforeEach {
                sut = AppContainer()
            }

            it("should build LoginViewController") {
                expect(sut.loginViewController()).to(beAnInstanceOf(LoginViewController.self))
            }

            it("should build UINavigationController") {
                expect(sut.navigationController(rootViewController: UIViewController()))
                    .to(beAnInstanceOf(UINavigationController.self))
            }

            it("should build SelectionViewController") {
                expect(sut.selectionViewController(googleIdToken: ""))
                    .to(beAnInstanceOf(SelectionViewController.self))
            }

            it("should build UIAlertController") {
                expect(sut.messageAlertController(with: nil, message: nil))
                    .to(beAnInstanceOf(UIAlertController.self))
            }

            it("should build ActivitiesViewController") {
                expect(sut.activitiesViewController()).to(beAnInstanceOf(ActivitiesViewController.self))
            }

            it("should build ActivityViewController") {
                expect(sut.activityViewController(activityType: .new(Date()), projectScope: []))
                    .to(beAnInstanceOf(ActivityViewController.self))
            }

            it("should build ProjectSearchViewController") {
                expect(sut.projectSearchViewController(projectId: nil))
                    .to(beAnInstanceOf(ProjectSearchViewController.self))
            }

            it("should build MonthPickerViewController") {
                expect(sut.monthPicker()).to(beAnInstanceOf(MonthPickerViewController.self))
            }
        }
    }
}
