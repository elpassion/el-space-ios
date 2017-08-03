import Quick
import Nimble
import Alamofire
import RxBlocking

@testable import ELSpace

class RequestPerformerSpec: QuickSpec {

    override func spec() {
        describe("RequestPerformer") {

            var sut: RequestPerformer!
            var requestWrapperSpy: RequestWrapperSpy!

            beforeEach {
                requestWrapperSpy = RequestWrapperSpy()
                sut = RequestPerformer(sessionManager: requestWrapperSpy)
            }

            context("when sending correct request") {
                var receivedResponse: Response!
                var fakeData: Data!

                beforeEach {
                    fakeData = Data()
                    let fakeResponse: (HTTPURLResponse, Data) = (HTTPURLResponse(url: URL(string: "www.fake_url.com")!,
                                                                                 statusCode: 200,
                                                                                 httpVersion: nil,
                                                                                 headerFields: nil)!, fakeData)
                    requestWrapperSpy.response = fakeResponse
                    receivedResponse = try! sut.request(URL(string: "www.fake_url.com")!,
                                                        method: .post,
                                                        parameters: ["fake_param": "fake_value"],
                                                        headers: ["fake_header": "fake_value"]).toBlocking().first()!
                }

                it("should set correct url") {
                    expect(try! requestWrapperSpy.url!.asURL().absoluteString).to(equal("www.fake_url.com"))
                }

                it("should set correct method") {
                    expect(requestWrapperSpy.method!).to(equal(HTTPMethod.post))
                }

                it("should set correct parameters") {
                    expect((requestWrapperSpy.parameters!["fake_param"] as! String)).to(equal("fake_value"))
                }

                it("should set correct encoding") {
                    expect((requestWrapperSpy.encoding as! URLEncoding).destination == .queryString).to(beTrue())
                }

                it("should set correct headers") {
                    expect(requestWrapperSpy.headers!["fake_header"]).to(equal("fake_value"))
                }

                describe("response") {
                    it("should have correct status code") {
                        expect(receivedResponse.statusCode).to(equal(200))
                    }

                    it("should have correct data") {
                        expect(receivedResponse.data == fakeData).to(beTrue())
                    }
                }
            }
        }
    }

}
