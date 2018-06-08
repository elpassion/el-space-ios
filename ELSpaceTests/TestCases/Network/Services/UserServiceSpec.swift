import Quick
import Nimble

@testable import ELSpace

class UserServiceSpec: QuickSpec {

    override func spec() {
        describe("UserService") {

            var sut: UserService!
            var apiClientSpy: ApiClientSpy!

            beforeEach {
                apiClientSpy = ApiClientSpy()
                sut = UserService(apiClient: apiClientSpy)
            }

            context("when getUser called") {
                var response: UserDTO!

                beforeEach {
                    let fakeDict = ["id": 999]
                    let fakeJson = try! JSONSerialization.data(withJSONObject: fakeDict, options: [])
                    let fakeResponse = Response(statusCode: 200, data: fakeJson)
                    apiClientSpy.response = fakeResponse
                    response = try! sut.getUser().toBlocking().first()!
                }

                it("should have correct path") {
                    expect(apiClientSpy.path).to(equal("users/me"))
                }

                it("should have correct method") {
                    expect(apiClientSpy.method).to(equal(.get))
                }

                it("should have parameters set to nil") {
                    expect(apiClientSpy.parameters).to(beNil())
                }

                it("should have headers set to nil") {
                    expect(apiClientSpy.headers).to(beNil())
                }

                describe("Response") {
                    it("should have correct id") {
                        expect(response.id).to(equal(999))
                    }
                }
            }
        }
    }
}
