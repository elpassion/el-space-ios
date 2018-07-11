import Quick
import Nimble
import RxTest

@testable import ELSpace

class ActivityFormViewModelSpec: QuickSpec {

    override func spec() {
        describe("ActivityFormViewModel") {
            var sut: ActivityFormViewModel!
            var scheduler: TestScheduler!
            var performedAtObserver: TestableObserver<String>!
            var projectsNamesObserver: TestableObserver<[String]>!
            var projectSelectedObserver: TestableObserver<String>!
            var projectInputHiddenObserver: TestableObserver<Bool>!
            var hoursObserver: TestableObserver<String>!
            var hoursInputHiddenObserver: TestableObserver<Bool>!
            var commentObserver: TestableObserver<String>!
            var commentInputHiddenObserver: TestableObserver<Bool>!
            var formObserver: TestableObserver<ActivityForm>!

            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
                performedAtObserver = scheduler.createObserver(String.self)
                projectsNamesObserver = scheduler.createObserver([String].self)
                projectSelectedObserver = scheduler.createObserver(String.self)
                projectInputHiddenObserver = scheduler.createObserver(Bool.self)
                hoursObserver = scheduler.createObserver(String.self)
                hoursInputHiddenObserver = scheduler.createObserver(Bool.self)
                commentObserver = scheduler.createObserver(String.self)
                commentInputHiddenObserver = scheduler.createObserver(Bool.self)
                formObserver = scheduler.createObserver(ActivityForm.self)
                let report = ReportDTO(id: 1,
                                       userId: 2,
                                       projectId: 3,
                                       value: "4",
                                       performedAt: "5",
                                       comment: "6",
                                       createdAt: "7",
                                       updatedAt: "8",
                                       billable: true,
                                       reportType: 0)
                let project1 = ProjectDTO(name: "test project name 1", id: 0)
                let project2 = ProjectDTO(name: "test project name 2", id: 1)
                let project3 = ProjectDTO(name: "test project name 3", id: 2)
                sut  = ActivityFormViewModel(activityType: ActivityType.report(report), projectScope: [project1, project2, project3])
                _ = sut.performedAt.subscribe(performedAtObserver)
                _ = sut.projectNames.subscribe(projectsNamesObserver)
                _ = sut.projectSelected.subscribe(projectSelectedObserver)
                _ = sut.projectInputHidden.subscribe(projectInputHiddenObserver)
                _ = sut.hours.subscribe(hoursObserver)
                _ = sut.hoursInputHidden.subscribe(hoursInputHiddenObserver)
                _ = sut.comment.subscribe(commentObserver)
                _ = sut.commentInputHidden.subscribe(commentInputHiddenObserver)
                _ = sut.form.subscribe(formObserver)
            }

            describe("inputs") {
                context("when selecting timeReport, vacation, dayOff, sickLeave, conference") {
                    beforeEach {
                        sut.type.onNext(.normal)
                        sut.type.onNext(.paidVacations)
                        sut.type.onNext(.unpaidDayOff)
                        sut.type.onNext(.sickLeave)
                        sut.type.onNext(.conference)
                    }

                    it("should project input not be visible") {
                        expect(projectInputHiddenObserver.events.map { $0.value.element! }).to(equal([false, false, true, true, true, true]))
                    }

                    it("should hours input not be visible") {
                        expect(hoursInputHiddenObserver.events.map { $0.value.element! }).to(equal([false, false, false, true, true, true]))
                    }

                    it("should comment input not be visible") {
                        expect(commentInputHiddenObserver.events.map { $0.value.element! }).to(equal([false, false, true, true, true, true]))
                    }
                }
            }

            describe("projects") {
                it("should have correct project names") {
                    expect(projectsNamesObserver.events.last?.value.element).to(equal(["test project name 1", "test project name 2", "test project name 3"]))
                }
            }

            describe("hours") {
                it("should have proper initial hours (4)") {
                    expect(hoursObserver.events.last?.value.element).to(equal("4"))
                }

                context("when updating") {
                    beforeEach {
                        sut.updateHours.onNext("7")
                    }

                    it("should have proper hours (7)") {
                        expect(hoursObserver.events.last?.value.element).to(equal("7"))
                    }
                }
            }

            describe("comment") {
                it("should have proper initial comment") {
                    expect(commentObserver.events.last?.value.element).to(equal("6"))
                }

                context("when updating") {
                    beforeEach {
                        sut.updateComment.onNext("123")
                    }

                    it("should have proper comment") {
                        expect(commentObserver.events.last?.value.element).to(equal("123"))
                    }
                }
            }
        }
    }

}
