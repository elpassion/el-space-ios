import Quick
import Nimble
@testable import ELSpace

class ProjectSearchControllerSpec: QuickSpec {

    override func spec() {
        describe("ProjectSearchController") {
            var projectService: ProjectsServiceStub!
            var sut: ProjectSearchController!

            beforeEach {
                projectService = ProjectsServiceStub()
                sut = ProjectSearchController(projectsService: projectService)
            }

            context("when requesting projects") {
                var project1: ProjectDTO!
                var project2: ProjectDTO!
                var caughtProjects: [ProjectDTO]?

                beforeEach {
                    project1 = ProjectDTO.fakeProjectDto(name: "One", id: 1)
                    project2 = ProjectDTO.fakeProjectDto(name: "Two", id: 2)
                    projectService.result = [project1, project2]
                    _ = sut.projects.subscribe(onNext: { caughtProjects = $0 })
                }

                afterEach {
                    project1 = nil
                    project2 = nil
                }

                it("should provide correct projects") {
                    expect(caughtProjects).to(haveCount(2))
                    expect(caughtProjects?.first?.id) == project1.id
                    expect(caughtProjects?.last?.id) == project2.id
                }
            }
        }
    }

}
