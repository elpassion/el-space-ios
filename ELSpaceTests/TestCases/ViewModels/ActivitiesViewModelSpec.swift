import Quick
import Nimble
import RxTest

@testable import ELSpace

class ActivitiesViewModelSpec: QuickSpec {

    override func spec() {
        describe("ActivitiesViewModel") {

            var sut: ActivitiesViewModel!
            var activitiesControllerSpy: ActivitiesControllerSpy!
            var scheduler: TestScheduler!
            var dataSourceObserver: TestableObserver<[DailyReportViewModelProtocol]>!
            var isLoadingObserver: TestableObserver<Bool>!
            var fakeTodayDate: Date!

            afterEach {
                sut = nil
                activitiesControllerSpy = nil
                scheduler = nil
                dataSourceObserver = nil
                isLoadingObserver = nil
            }

            beforeEach {
                fakeTodayDate = DateFormatter.shortDateFormatter.date(from: "2017-12-07")
                activitiesControllerSpy = ActivitiesControllerSpy()
                sut = ActivitiesViewModel(activitiesController: activitiesControllerSpy,
                                          todayDate: fakeTodayDate)
                scheduler = TestScheduler(initialClock: 0)
                dataSourceObserver = scheduler.createObserver(Array<DailyReportViewModelProtocol>.self)
                isLoadingObserver = scheduler.createObserver(Bool.self)
                _ = sut.dataSource.subscribe(dataSourceObserver)
                _ = sut.isLoading.subscribe(isLoadingObserver)
                activitiesControllerSpy.projectsSubject.onNext([ProjectDTO.fakeProjectDto()])
                activitiesControllerSpy.reportsSubject.onNext([ReportDTO.fakeReportDto()])
            }

            it("should have correct month") {
                expect(sut.month).to(equal(DateFormatter.monthFormatter.string(from: fakeTodayDate)))
            }

            context("when call 'getData'") {
                beforeEach {
                    sut.getData()
                }

                it("should call 'getReports'") {
                    expect(activitiesControllerSpy.didCallGetReports).to(beTrue())
                }

                it("should call 'getProjects'") {
                    expect(activitiesControllerSpy.didCallGetProjects).to(beTrue())
                }

                it("should dataSource NOT emit any envets") {
                    expect(dataSourceObserver.events).to(haveCount(0))
                }

                context("when receive didFinishFetch event") {
                    beforeEach {
                        activitiesControllerSpy.didFinishFetchSubject.onNext(())
                    }

                    it("should dataSource emit one event") {
                        expect(dataSourceObserver.events).to(haveCount(1))
                    }

                    describe("viewModels") {
                        var viewModels: [DailyReportViewModelProtocol]!

                        beforeEach {
                            viewModels = dataSourceObserver.events.first?.value.element
                        }

                        it("should have correct number of elements") {
                            expect(viewModels).to(haveCount(31))
                        }

                        describe("1st viewModel") {
                            var viewModel: DailyReportViewModelProtocol!

                            beforeEach {
                                viewModel = viewModels[0]
                            }

                            it("should have correct topCornersRounded value") {
                                expect(viewModel.topCornersRounded).to(beTrue())
                            }

                            it("should have correct bottomCornersRounded value") {
                                expect(viewModel.bottomCornersRounded).to(beTrue())
                            }

                            it("should have correct isSeparatoHidden value") {
                                expect(viewModel.isSeparatorHidden).to(beTrue())
                            }
                        }

                        describe("2nd viewModel") {
                            var viewModel: DailyReportViewModelProtocol!

                            beforeEach {
                                viewModel = viewModels[1]
                            }

                            it("should have correct topCornersRounded value") {
                                expect(viewModel.topCornersRounded).to(beFalse())
                            }

                            it("should have correct bottomCornersRounded value") {
                                expect(viewModel.bottomCornersRounded).to(beFalse())
                            }

                            it("should have correct isSeparatoHidden value") {
                                expect(viewModel.isSeparatorHidden).to(beFalse())
                            }
                        }

                        describe("3rd viewModel") {
                            var viewModel: DailyReportViewModelProtocol!

                            beforeEach {
                                viewModel = viewModels[2]
                            }

                            it("should have correct topCornersRounded value") {
                                expect(viewModel.topCornersRounded).to(beFalse())
                            }

                            it("should have correct bottomCornersRounded value") {
                                expect(viewModel.bottomCornersRounded).to(beFalse())
                            }

                            it("should have correct isSeparatoHidden value") {
                                expect(viewModel.isSeparatorHidden).to(beTrue())
                            }
                        }

                        describe("4th viewModel") {
                            var viewModel: DailyReportViewModelProtocol!

                            beforeEach {
                                viewModel = viewModels[3]
                            }

                            it("should have correct topCornersRounded value") {
                                expect(viewModel.topCornersRounded).to(beTrue())
                            }

                            it("should have correct bottomCornersRounded value") {
                                expect(viewModel.bottomCornersRounded).to(beFalse())
                            }

                            it("should have correct isSeparatoHidden value") {
                                expect(viewModel.isSeparatorHidden).to(beFalse())
                            }
                        }

                        describe("5th viewModel") {
                            var viewModel: DailyReportViewModelProtocol!

                            beforeEach {
                                viewModel = viewModels[4]
                            }

                            it("should have correct topCornersRounded value") {
                                expect(viewModel.topCornersRounded).to(beFalse())
                            }

                            it("should have correct bottomCornersRounded value") {
                                expect(viewModel.bottomCornersRounded).to(beFalse())
                            }

                            it("should have correct isSeparatoHidden value") {
                                expect(viewModel.isSeparatorHidden).to(beFalse())
                            }
                        }

                        describe("6th viewModel") {
                            var viewModel: DailyReportViewModelProtocol!

                            beforeEach {
                                viewModel = viewModels[5]
                            }

                            it("should have correct topCornersRounded value") {
                                expect(viewModel.topCornersRounded).to(beFalse())
                            }

                            it("should have correct bottomCornersRounded value") {
                                expect(viewModel.bottomCornersRounded).to(beFalse())
                            }

                            it("should have correct isSeparatoHidden value") {
                                expect(viewModel.isSeparatorHidden).to(beFalse())
                            }
                        }

                        describe("7th viewModel") {
                            var viewModel: DailyReportViewModelProtocol!

                            beforeEach {
                                viewModel = viewModels[6]
                            }

                            it("should have correct topCornersRounded value") {
                                expect(viewModel.topCornersRounded).to(beFalse())
                            }

                            it("should have correct bottomCornersRounded value") {
                                expect(viewModel.bottomCornersRounded).to(beFalse())
                            }

                            it("should have correct isSeparatoHidden value") {
                                expect(viewModel.isSeparatorHidden).to(beFalse())
                            }
                        }

                        describe("8th viewModel") {
                            var viewModel: DailyReportViewModelProtocol!

                            beforeEach {
                                viewModel = viewModels[7]
                            }

                            it("should have correct topCornersRounded value") {
                                expect(viewModel.topCornersRounded).to(beFalse())
                            }

                            it("should have correct bottomCornersRounded value") {
                                expect(viewModel.bottomCornersRounded).to(beTrue())
                            }

                            it("should have correct isSeparatoHidden value") {
                                expect(viewModel.isSeparatorHidden).to(beTrue())
                            }
                        }

                        describe("9th viewModel") {
                            var viewModel: DailyReportViewModelProtocol!

                            beforeEach {
                                viewModel = viewModels[8]
                            }

                            it("should have correct topCornersRounded value") {
                                expect(viewModel.topCornersRounded).to(beFalse())
                            }

                            it("should have correct bottomCornersRounded value") {
                                expect(viewModel.bottomCornersRounded).to(beFalse())
                            }

                            it("should have correct isSeparatoHidden value") {
                                expect(viewModel.isSeparatorHidden).to(beFalse())
                            }
                        }
                    }
                }
            }

            context("when ActivitiesController emit isLoading event") {
                beforeEach {
                    activitiesControllerSpy.isLoadingSubject.onNext(true)
                }

                describe("isLoading") {
                    it("should emit correct event") {
                        expect(isLoadingObserver.events.first?.value.element).to(beTrue())
                    }
                }
            }
        }
    }

}
