import Quick
import Nimble

@testable import ELSpace

class SelectionControllerSpec: QuickSpec {

    override func spec() {
        describe("SelectionController") {

            var sut: SelectionController!
            var hubTokenServiceSpy: HubTokenServiceSpy!

            beforeEach {
                hubTokenServiceSpy = HubTokenServiceSpy()
                sut = SelectionController(hubTokenService: hubTokenServiceSpy,
                                          googleIdToken: "fake_token")
            }

            afterEach {
                hubTokenServiceSpy = nil
                sut = nil
            }

            context("when sign in to hub with success") {
                var recivedToken: String?
                var receivedError: Error?

                beforeEach {
                    hubTokenServiceSpy.result = "fake_token"
                    sut.signInToHub(success: { token in
                        recivedToken = token
                    }, failure: { error in
                        receivedError = error
                    })
                }

                it("should receive correct token") {
                    expect(recivedToken).to(equal("fake_token"))
                }

                it("should NOT receive error") {
                    expect(receivedError).to(beNil())
                }
            }

            context("when sign in with error") {
                var recivedToken: String?
                var receivedError: Error?

                beforeEach {
                    sut.signInToHub(success: { token in
                        recivedToken = token
                    }, failure: { error in
                        receivedError = error
                    })
                }

                it("should NOT receive token") {
                    expect(recivedToken).to(beNil())
                }

                it("should receive error") {
                    expect(receivedError).notTo(beNil())
                }
            }
        }
    }

}
