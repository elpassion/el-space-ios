import Quick
import Nimble

@testable import ELSpace

class HubTokenSpec: QuickSpec {

    override func spec() {
        describe("hubToken") {

            var jsonData: Data!

            context("when json data is correct") {
                beforeEach {
                    let dict = ["access_token": "fake_token"]
                    jsonData = try! JSONSerialization.data(withJSONObject: dict, options: [])
                }

                it("should return correct access token") {
                    expect(jsonData.hubToken).to(equal("fake_token"))
                }
            }

            context("when data is NOT a json") {
                var testFunc: (() throws -> Void)!

                beforeEach {
                    jsonData = Data()
                    testFunc = { _ = jsonData.hubToken }
                }

                it("should throw fatalError") {
                    expect { try? testFunc() }.to(throwAssertion())
                }
            }

            context("when dict key is wrong") {
                var testFunc: (() throws -> Void)!

                beforeEach {
                    let dict = ["wrong key": "fake_token"]
                    jsonData = try! JSONSerialization.data(withJSONObject: dict, options: [])
                    testFunc = { _ = jsonData.hubToken }
                }

                it("should throw fatalError") {
                    expect { try? testFunc() }.to(throwAssertion())
                }
            }
        }
    }

}
