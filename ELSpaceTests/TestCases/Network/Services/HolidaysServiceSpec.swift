import Quick
import Nimble

@testable import ELSpace

class HolidaysServiceSpec: QuickSpec {

    override func spec() {
        describe("HolidaysService") {

            var sut: HolidaysService!
            var apiClientSpy: ApiClientSpy!

            beforeEach {
                apiClientSpy = ApiClientSpy()
                sut = HolidaysService(apiClient: apiClientSpy)
            }

            context("when call getHolidays with success") {
                var response: HolidaysDTO!

                beforeEach {
                    let fakeHolidaysDTO = [
                        "holidays": [1, 11]
                    ]
                    let fakeJson = try! JSONSerialization.data(withJSONObject: fakeHolidaysDTO, options: [])
                    let fakeResponse = Response(statusCode: 200, data: fakeJson)
                    apiClientSpy.response = fakeResponse
                    response = try! sut.getHolidays(month: 1, year: 2018).toBlocking().first()!
                    print(apiClientSpy.parameters)
                }

                it("should have correct path") {
                    expect(apiClientSpy.path).to(equal("holidays"))
                }

                it("should have correct method") {
                    expect(apiClientSpy.method).to(equal(.get))
                }

                describe("params") {
                    it("should have correct year value") {
                        expect(apiClientSpy.parameters?["year"] as? Int).to(equal(2018))
                    }

                    it("should have correct month value") {
                        expect(apiClientSpy.parameters?["month"] as? Int).to(equal(1))
                    }
                }

                it("should have correct headers") {
                    expect(apiClientSpy.headers).to(beNil())
                }

                describe("response") {
                    describe("days") {
                        it("should have correct number of elements") {
                            expect(response.days).to(haveCount(2))
                        }

                        describe("1st element") {
                            var element: Int!

                            beforeEach {
                                element = response.days[0]
                            }

                            it("should have correct value") {
                                expect(element).to(equal(1))
                            }
                        }

                        describe("2nd element") {
                            var element: Int!

                            beforeEach {
                                element = response.days[1]
                            }

                            it("should have correct value") {
                                expect(element).to(equal(11))
                            }
                        }
                    }
                }
            }

            context("when receive error status code") {
                beforeEach {
                    apiClientSpy.response = Response(statusCode: 999, data: Data())
                }

                it("should throw APIError") {
                    expect { try sut.getHolidays(month: 1, year: 2018).toBlocking().first() }.to(throwError(errorType: ApiError.self))
                }
            }
        }
    }

}
