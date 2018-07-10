import Quick
import Nimble

@testable import ELSpace

class ProjectsServiceSpec: QuickSpec {

    override func spec() {
        describe("ProjectService") {

            var sut: ProjectsService!
            var apiClientSpy: ApiClientSpy!

            beforeEach {
                apiClientSpy = ApiClientSpy()
                sut = ProjectsService(apiClient: apiClientSpy)
            }

            context("when call getProjects with success") {
                var response: [ProjectDTO]!

                beforeEach {
                    let fakeResponse = [
                        ["id": 1, "name": "fake_name1"],
                        ["id": 2, "name": "fake_name2"]
                    ]
                    let fakeJson = try! JSONSerialization.data(withJSONObject: fakeResponse, options: [])
                    apiClientSpy.response = Response(statusCode: 200, data: fakeJson)
                    response = try! sut.getProjects().toBlocking().first()!
                }

                it("should have correct path") {
                    expect(apiClientSpy.path).to(equal("projects"))
                }

                it("should have correct method") {
                    expect(apiClientSpy.method).to(equal(.get))
                }

                it("should have correct params") {
                    expect(apiClientSpy.parameters as? [String: String]).to(equal(["sort": "recent"]))
                }

                it("should have correct headers") {
                    expect(apiClientSpy.headers).to(beNil())
                }

                describe("response") {
                    it("should have 2 elements") {
                        expect(response).to(haveCount(2))
                    }

                    describe("first elements") {
                        var element: ProjectDTO!

                        beforeEach {
                            element = response.first!
                        }

                        it("should have correct id") {
                            expect(element.id).to(equal(1))
                        }

                        it("should have correct name") {
                            expect(element.name).to(equal("fake_name1"))
                        }
                    }

                    describe("first elements") {
                        var element: ProjectDTO!

                        beforeEach {
                            element = response[1]
                        }

                        it("should have correct id") {
                            expect(element.id).to(equal(2))
                        }

                        it("should have correct name") {
                            expect(element.name).to(equal("fake_name2"))
                        }
                    }
                }
            }
        }
    }

}
