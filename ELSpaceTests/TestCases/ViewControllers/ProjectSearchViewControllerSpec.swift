@testable import ELSpace
import Quick
import Nimble
import RxSwift
import RxCocoa

class ProjectSearchViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ProjectSearchViewController") {

            describe("from coder") {
                it("should return nil") {
                    expect(ProjectSearchViewController(coder: NSCoder())).to(beNil())
                }
            }

            var sut: ProjectSearchViewController!

            beforeEach {
                sut = ProjectSearchViewController()
            }

            describe("view") {
                var projectSearchView: ProjectSearchView!

                beforeEach {
                    projectSearchView = sut.view as? ProjectSearchView
                }

                it("should create view") {
                    expect(projectSearchView).notTo(beNil())
                }

                it("should setup navigation bar") {
                    expect(sut.navigationItem.titleView).to(beAnInstanceOf(UILabel.self))
                    expect((sut.navigationItem.titleView as? UILabel)?.text) == "Project"
                }

                describe("tableView") {
                    var project1: ProjectDTO!
                    var project2: ProjectDTO!
                    var project3: ProjectDTO!

                    beforeEach {
                        project1 = ProjectDTO.fakeProjectDto(name: "One", id: 1)
                        project2 = ProjectDTO.fakeProjectDto(name: "Two", id: 2)
                        project3 = ProjectDTO.fakeProjectDto(name: "Three", id: 3)
                        sut.projectRelay.accept([project1, project2, project3])
                    }

                    it("should have correct number of rows") {
                        expect(projectSearchView.tableView.numberOfSections) == 1
                        expect(projectSearchView.tableView.numberOfRows(inSection: 0)) == 3
                    }

                    describe("cell") {
                        var cell: UITableViewCell!

                        beforeEach {
                            cell = projectSearchView.tableView.dataSource?.tableView(projectSearchView.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                        }

                        it("should contain correct data") {
                            expect(cell.textLabel?.text) == "One"
                        }

                        context("when project was previously selected") {
                            var secondCell: UITableViewCell!

                            beforeEach {
                                sut.selectedProjectIdObserver.onNext(2)
                                secondCell = projectSearchView.tableView.dataSource?.tableView(projectSearchView.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
                            }

                            it("cell should have checkmark") {
                                expect(secondCell.accessoryType) == .checkmark
                            }
                        }
                    }

                    describe("search text") {
                        var caughtSearchText: String!

                        beforeEach {
                            _ = sut.searchText.subscribe(onNext: { caughtSearchText = $0 })
                            projectSearchView.searchBar.text = "ASDfg"
                            projectSearchView.searchBar.delegate!.searchBar!(projectSearchView.searchBar, textDidChange: "ASDfg")
                        }

                        it("should emit correct text") {
                            expect(caughtSearchText) == "ASDfg"
                        }
                    }

                    describe("selecting cell") {
                        var caughtDidSelectProject: ProjectDTO!

                        beforeEach {
                            _ = sut.didSelectProject.subscribe(onNext: { caughtDidSelectProject = $0 })
                            projectSearchView.tableView.delegate!.tableView!(projectSearchView.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        }

                        it("should emit correct project") {
                            expect(caughtDidSelectProject.id) == project1.id
                        }
                    }
                }
            }
        }
    }

}
