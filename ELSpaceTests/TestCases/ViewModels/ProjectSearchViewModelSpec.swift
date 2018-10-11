@testable import ELSpace
import Quick
import Nimble
import RxSwift
import RxCocoa

class ProjectSearchViewModelSpec: QuickSpec {

    override func spec() {
        describe("ProjectSearchViewModel") {
            var projectSearchController: ProjectSearchControllerStub!
            var sut: ProjectSearchViewModel!
            var projectId: Int!

            beforeEach {
                projectId = 4
                projectSearchController = ProjectSearchControllerStub()
                sut = ProjectSearchViewModel(projectId: projectId, projectSearchController: projectSearchController)
            }

            context("when projects are supplied") {
                var project1: ProjectDTO!
                var project2: ProjectDTO!
                var project3: ProjectDTO!
                var caughtProjects: [ProjectDTO]!

                beforeEach {
                    project1 = ProjectDTO.fakeProjectDto(name: "One", id: 1)
                    project2 = ProjectDTO.fakeProjectDto(name: "Two", id: 2)
                    project3 = ProjectDTO.fakeProjectDto(name: "Three", id: 3)

                    _ = sut.projects.drive(onNext: { caughtProjects = $0 })
                    projectSearchController.stubbedProjects.onNext([project1, project2, project3])
                }

                afterEach {
                    caughtProjects = nil
                }

                it("should emit all projects") {
                    expect(caughtProjects).to(haveCount(3))
                }

                context("when search text is supplied") {
                    context("correct text") {
                        beforeEach {
                            sut.searchText.onNext("T")
                        }

                        it("should emit filtered projects") {
                            expect(caughtProjects).to(haveCount(2))
                            expect(caughtProjects[0].id) == project2.id
                            expect(caughtProjects[1].id) == project3.id
                        }
                    }

                    context("empty text") {
                        beforeEach {
                            sut.searchText.onNext("")
                        }

                        it("should emit filtered projects") {
                            expect(caughtProjects).to(haveCount(3))
                            expect(caughtProjects[0].id) == project1.id
                            expect(caughtProjects[1].id) == project2.id
                            expect(caughtProjects[2].id) == project3.id
                        }
                    }
                }

                context("when project is selected") {
                    var caughtProject: ProjectDTO!

                    beforeEach {
                        _ = sut.didSelectProject.drive(onNext: { caughtProject = $0 })
                        sut.selectProject.onNext(project2)
                    }

                    it("should emit correct project") {
                        expect(caughtProject!.id) == project2.id
                    }
                }
            }
        }
    }

}
