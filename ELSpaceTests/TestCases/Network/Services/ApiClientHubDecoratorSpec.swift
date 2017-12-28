import Quick
import Nimble
import Alamofire

@testable import ELSpace

class ApiClientHubDecoratorSpec: QuickSpec {

    override func spec() {
        describe("ApiClientHubDecorator") {

            var sut: ApiClientHubDecorator!
            var apiClientSpy: ApiClientSpy!
            var hubSession: HubSession!

            beforeEach {
                apiClientSpy = ApiClientSpy()
                hubSession = HubSession()
                sut = ApiClientHubDecorator(apiClient: apiClientSpy, hubSession: hubSession)
            }

            context("when access token is nil") {
                var response: Response!

                beforeEach {
                    let fakeResponse = Response(statusCode: 999, data: Data())
                    apiClientSpy.response = fakeResponse
                    response = try! sut.request(path: "fake_path",
                                                method: .get,
                                                parameters: ["fake_param_key": "fake_value"],
                                                encoding: nil,
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
                    expect(apiClientSpy.headers).to(equal([:]))
                }

                describe("Response") {
                    it("should have correct status code") {
                        expect(response.statusCode).to(equal(999))
                    }
                }
            }

            context("when access tokem is NOT nil") {
                var response: Response!

                beforeEach {
                    hubSession.accessToken = "fake_token"
                    let fakeResponse = Response(statusCode: 999, data: Data())
                    apiClientSpy.response = fakeResponse
                    response = try! sut.request(path: "fake_path",
                                                method: .get,
                                                parameters: ["fake_param_key": "fake_value"],
                                                encoding: nil,
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

                describe("Response") {
                    it("should have correct status code") {
                        expect(response.statusCode).to(equal(999))
                    }
                }
            }
        }
    }

}
