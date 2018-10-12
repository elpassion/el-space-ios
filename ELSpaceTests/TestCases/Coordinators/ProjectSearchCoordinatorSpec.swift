import Quick
import Nimble
@testable import ELSpace

class ProjectSearchCoordinatorSpec: QuickSpec {

    override func spec() {
        describe("ProjectSearchCoordinator") {
            var projectSearchViewController: ProjectSearchViewControllerStub!
            var projectSearchViewModel: ProjectSearchViewModelStub!
            var sut: ProjectSearchCoordinator!

            beforeEach {
                projectSearchViewController = ProjectSearchViewControllerStub()
                projectSearchViewModel = ProjectSearchViewModelStub()
                sut = ProjectSearchCoordinator(
                    projectSearchViewController: projectSearchViewController,
                    projectSearchViewModel: projectSearchViewModel
                )
            }

            it("should have correct initialViewController") {
                expect(sut.initialViewController) === projectSearchViewController
            }

            describe("bindings") {
                var fakeProjects: [ProjectDTO]!
                var project1: ProjectDTO!
                var project2: ProjectDTO!
                var project3: ProjectDTO!

                beforeEach {
                    project1 = ProjectDTO.fakeProjectDto(name: "One", id: 1)
                    project2 = ProjectDTO.fakeProjectDto(name: "Two", id: 2)
                    project3 = ProjectDTO.fakeProjectDto(name: "Three", id: 3)
                    fakeProjects = [project1, project2]
                    projectSearchViewModel.stubbedProjects.onNext(fakeProjects)
                    projectSearchViewController.stubbedSearchText.onNext("ASDfghj")
                    projectSearchViewController.stubbedDidSelectProject.onNext(project3)
                }

                it("should bind viewModel to viewController") {
                    expect(projectSearchViewController.projectRelay.value).to(haveCount(2))
                    expect(projectSearchViewController.projectRelay.value[0].id) == project1.id
                    expect(projectSearchViewController.projectRelay.value[1].id) == project2.id
                }

                it("should bind viewController to viewModel") {
                    expect(projectSearchViewModel.caugthSearchText) == "ASDfghj"
                    expect(projectSearchViewModel.caughtSelectProject?.id) == project3.id
                }
            }

        }
    }

}
