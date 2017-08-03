import Quick
import Nimble

@testable import ELSpace

class ReportsServiceSpec: QuickSpec {

    override func spec() {
        describe("ReportsService") {

            var sut: ReportsService!
            var apiClientSpy: ApiClientSpy!

            beforeEach {
                apiClientSpy = ApiClientSpy()
                sut = ReportsService(apiClient: apiClientSpy)
            }

            context("when call getReports") {
                var response: [ReportDTO]!

                beforeEach {
                    let fakeArray = [
                        ["id": 0,
                         "user_id": 0,
                         "project_id": 0,
                         "value": "8",
                         "performed_at": "fake_performed_at",
                         "comment": "fake_comment",
                         "created_at": "fake_created_at",
                         "updated_at": "fake_updated_at",
                         "billable": true,
                         "report_type": 0]
                    ]
                    let fakeJson = try! JSONSerialization.data(withJSONObject: fakeArray, options: [])
                    let fakeResponse = Response(statusCode: 200, data: fakeJson)
                    apiClientSpy.response = fakeResponse
                    response = try! sut.getReports(startDate: "fake_start_date", endDate: "fake_end_date").toBlocking().first()!
                }

                it("should have correct path") {
                    expect(apiClientSpy.path).to(equal("activities"))
                }

                it("should have correct method") {
                    expect(apiClientSpy.method).to(equal(.get))
                }

                describe("parameters") {
                    it("should contain 'start_date' with correct value") {
                        expect(apiClientSpy.parameters!["start_date"] as? String).to(equal("fake_start_date"))
                    }

                    it("should contain 'end_date' with correct value") {
                        expect(apiClientSpy.parameters!["end_date"] as? String).to(equal("fake_end_date"))
                    }
                }

                it("should headers be nil") {
                    expect(apiClientSpy.headers).to(beNil())
                }

                describe("Response") {
                    it("should have one elements") {
                        expect(response).to(haveCount(1))
                    }

                    describe("first element") {
                        var element: ReportDTO!

                        beforeEach {
                            element = response.first!
                        }

                        it("should have correct 'id'") {
                            expect(element.id).to(equal(0))
                        }

                        it("should have correct 'userId'") {
                            expect(element.userId).to(equal(0))
                        }

                        it("should have correct 'projectId'") {
                            expect(element.projectId).to(equal(0))
                        }

                        it("should have correct 'value'") {
                            expect(element.value).to(equal("8"))
                        }

                        it("should have correct 'performedAt'") {
                            expect(element.performedAt).to(equal("fake_performed_at"))
                        }

                        it("should have correct 'comment'") {
                            expect(element.comment).to(equal("fake_comment"))
                        }

                        it("should have correct 'createdAt'") {
                            expect(element.createdAt).to(equal("fake_created_at"))
                        }

                        it("should have correct 'updatedAt'") {
                            expect(element.updatedAt).to(equal("fake_updated_at"))
                        }

                        it("should have correct 'billable'") {
                            expect(element.billable).to(beTrue())
                        }

                        it("should have correct 'reportType'") {
                            expect(element.reportType).to(equal(0))
                        }
                    }
                }
            }
        }
    }

}
