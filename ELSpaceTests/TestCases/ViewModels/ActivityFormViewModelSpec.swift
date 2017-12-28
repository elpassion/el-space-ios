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
                sut  = ActivityFormViewModel()
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

            describe("date") {
                beforeEach {
                    let dateFormatter = DateFormatter.activityFormatter
                    let date = dateFormatter.date(from: "Mon, 5 Sep 2016")!
                    sut.date.onNext(date)
                }

                it("should have correct performed at") {
                    expect(performedAtObserver.events.last?.value.element).to(equal("Mon, 5 Sep 2016"))
                }
            }

            describe("inputs") {
                context("when selecting timeReport, vacation, dayOff, sickLeave, conference") {
                    beforeEach {
                        sut.type.onNext(.timeReport)
                        sut.type.onNext(.vacation)
                        sut.type.onNext(.dayOff)
                        sut.type.onNext(.sickLeave)
                        sut.type.onNext(.conference)
                    }

                    it("should project input not be visible") {
                        expect(projectInputHiddenObserver.events.map { $0.value.element! }).to(equal([false, true, true, true, true]))
                    }

                    it("should hours input not be visible") {
                        expect(hoursInputHiddenObserver.events.map { $0.value.element! }).to(equal([false, false, true, true, true]))
                    }

                    it("should comment input not be visible") {
                        expect(commentInputHiddenObserver.events.map { $0.value.element! }).to(equal([false, true, true, true, true]))
                    }
                }
            }

            describe("projects") {
                it("should have correct project names") {
                    expect(projectsNamesObserver.events.last?.value.element).to(equal(["Project 1", "Project 2"]))
                }

                it("should have project 1 selected") {
                    expect(projectSelectedObserver.events.last?.value.element).to(equal("Project 1"))
                }

                context("when selecting") {
                    beforeEach {
                        sut.selectProject.onNext("Project 2")
                    }

                    it("should have project 2 selected") {
                        expect(projectSelectedObserver.events.last?.value.element).to(equal("Project 2"))
                    }
                }
            }

            describe("hours") {
                it("should have proper initial hours (8)") {
                    expect(hoursObserver.events.last?.value.element).to(equal("8"))
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
                    expect(commentObserver.events.last?.value.element).to(equal("ElSpace report form implementation"))
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
