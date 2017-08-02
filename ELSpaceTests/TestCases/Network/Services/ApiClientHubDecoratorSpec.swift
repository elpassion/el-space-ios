import Quick
import Nimble
import Alamofire

@testable import ELSpace

class ApiClientHubDecoratorSpec: QuickSpec {

    override func spec() {
        describe("ApiClientHubDecorator") {

            var sut: ApiClientHubDecorator!
            var apiClientSpy: ApiClientSpy!

            context("when initialize with empty hub session") {
                var response: Response!

                beforeEach {
                    apiClientSpy = ApiClientSpy()
                    sut = ApiClientHubDecorator(apiClient: apiClientSpy,
                                                hubSession: nil)
                    let fakeResponse = Response(statusCode: 999, data: Data())
                    apiClientSpy.response = fakeResponse
                    response = try! sut.request(path: "fake_path",
                                                method: .get,
                                                parameters: ["fake_param_key": "fake_value"],
                                                headers: nil).toBlocking().first()!
                }

                it("should have correct path") {
                    expect(apiClientSpy.path).to(equal("fake_path"))
                }

                it("should have correct method") {
                    expect(apiClientSpy.method).to(equal(HTTPMethod.get))
                }

                it("should have correct parameter") {
                    expect((apiClientSpy.parameters!["fake_param_key"] as? String)).to(equal("fake_value"))
                }

                it("should have correct header") {
                    expect(apiClientSpy.headers).to(beNil())
                }
            }

            context("when initialize with hub session") {
                var response: Response!

                beforeEach {
                    apiClientSpy = ApiClientSpy()
                    sut = ApiClientHubDecorator(apiClient: apiClientSpy,
                                                hubSession: HubSession(accessToken: "fake_token"))
                    let fakeResponse = Response(statusCode: 999, data: Data())
                    apiClientSpy.response = fakeResponse
                    response = try! sut.request(path: "fake_path",
                                                method: .get,
                                                parameters: ["fake_param_key": "fake_value"],
                                                headers: nil).toBlocking().first()!
                }

                it("should have correct path") {
                    expect(apiClientSpy.path).to(equal("fake_path"))
                }

                it("should have correct method") {
                    expect(apiClientSpy.method).to(equal(HTTPMethod.get))
                }

                it("should have correct parameter") {
                    expect((apiClientSpy.parameters!["fake_param_key"] as? String)).to(equal("fake_value"))
                }

                it("should have correct header") {
                    expect(apiClientSpy.headers!["X-Access-Token"]).to(equal("fake_token"))
                }
            }
        }
    }

}
