import Quick
import Nimble
import Alamofire

@testable import ELSpace

class ApiClientSpec: QuickSpec {

    override func spec() {
        describe("ApiClient") {
            var sut: ApiClient!
            var requestPerformerSpy: RequestPerformerSpy!

            beforeEach {
                requestPerformerSpy = RequestPerformerSpy()
                sut = ApiClient(requestPerformer: requestPerformerSpy)
            }

            context("when sending correct request") {
                let fakeData = Data()
                var receivedResponse: Response!

                beforeEach {
                    let fakeResponse = Response(statusCode: 200, data: fakeData)
                    requestPerformerSpy.response = fakeResponse
                    receivedResponse = try! sut.request(path: "fake_path",
                                                        method: .get,
                                                        parameters: ["fake_param": "fake_value"],
                                                        encoding: nil,
                                                        headers: ["fake_header": "fake_value"]).toBlocking().first()!
                }

                it("should have correct url") {
                    expect(try! requestPerformerSpy.url!.asURL().absoluteString).to(equal("https://hub.elpassion.com/api/v1/fake_path"))
                }

                it("should have correct method") {
                    expect(requestPerformerSpy.method!).to(equal(HTTPMethod.get))
                }

                it("should have correct param") {
                    expect((requestPerformerSpy.parameters!["fake_param"] as! String)).to(equal("fake_value"))
                }

                it("should have correct header") {
                    expect(requestPerformerSpy.headers!["fake_header"]).to(equal("fake_value"))
                }

                describe("reponse") {
                    it("should have correct status code") {
                        expect(receivedResponse.statusCode).to(equal(200))
                    }

                    it("should have correct data") {
                        expect(receivedResponse.data).to(equal(fakeData))
                    }
                }
            }
        }
    }

}
