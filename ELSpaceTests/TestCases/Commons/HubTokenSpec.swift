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
                beforeEach {
                    jsonData = Data()
                }

                it("should throw fatalError") {
                    let errorFunc: () throws -> Void = { _ = jsonData.hubToken }
                    expect { try? errorFunc() }.to(throwAssertion())
                }
            }

            context("when dict key is wrong") {
                beforeEach {
                    let dict = ["wrong key": "fake_token"]
                    jsonData = try! JSONSerialization.data(withJSONObject: dict, options: [])
                }

                it("should throw fatalError") {
                    let errorFunc: () throws -> Void = { _ = jsonData.hubToken }
                    expect { try? errorFunc() }.to(throwAssertion())
                }
            }
        }
    }

}
