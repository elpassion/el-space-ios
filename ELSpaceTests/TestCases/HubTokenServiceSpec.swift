import Quick
import Nimble
import Alamofire

@testable import ELSpace

class HubTokenServiceSpec: QuickSpec {

    override func spec() {
        describe("HubTokenService") {

            var sut: HubTokenService!
            var apiClientSpy: ApiClientSpy!

            beforeEach {
                apiClientSpy = ApiClientSpy()
                sut = HubTokenService(apiClient: apiClientSpy)
            }

            afterEach {
                sut = nil
                apiClientSpy = nil
            }

            context("when sending hub token request") {
                var resultHubToken: String!

                beforeEach {
                    let fakeDict = ["access_token": "fake_hub_token"]
                    let fakeJsonData = try! JSONSerialization.data(withJSONObject: fakeDict, options: [])
                    apiClientSpy.response = Response(statusCode: 200, data: fakeJsonData)
                    resultHubToken = try! sut.getHubToken(googleTokenId: "fake_google_token_id").toBlocking().first()!
                }

                it("should set correct path") {
                    expect(apiClientSpy.path).to(equal("api_keys"))
                }

                it("should set correct method") {
                    expect(apiClientSpy.method).to(equal(HTTPMethod.post))
                }

                it("should set correct parameters") {
                    expect(apiClientSpy.parameters!["id_token"] as? String).to(equal("fake_google_token_id"))
                }

                describe("response") {
                    it("should have correct hub token") {
                        expect(resultHubToken).to(equal("fake_hub_token"))
                    }
                }
            }

            context("when sending hub token request and receive error status code") {
                beforeEach {
                    apiClientSpy.response = Response(statusCode: 401, data: Data())
                }

                it("should throw apiError") {
                    expect { try sut.getHubToken(googleTokenId: "fake_google_token_id").toBlocking().first() }
                        .to(throwError(errorType: ApiError.self))
                }
            }
        }
    }

}
