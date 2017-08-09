import Quick
import Nimble

@testable import ELSpace

class JsonArraySpec: QuickSpec {

    override func spec() {
        describe("JsonArray") {

            var jsonData: Data!

            afterEach {
                jsonData = nil
            }

            context("when json data is correct") {
                var result: [[String: AnyObject]]!

                beforeEach {
                    let array = [
                        ["fake_key1": "fake_value1"],
                        ["fake_key2": "fake_value2"]
                    ]
                    jsonData = try! JSONSerialization.data(withJSONObject: array, options: [])
                    result = jsonData.jsonArray
                }

                describe("result") {
                    it("should have correct number of elements") {
                        expect(result).to(haveCount(2))
                    }

                    describe("first element") {
                        var dict: [String: AnyObject]!

                        beforeEach {
                            dict = result.first!
                        }

                        it("should have correct number of elements") {
                            expect(dict).to(haveCount(1))
                        }

                        describe("fake_key1") {
                            it("should have correct value") {
                                expect(dict["fake_key1"] as? String).to(equal("fake_value1"))
                            }
                        }
                    }

                    describe("second element") {
                        var dict: [String: AnyObject]!

                        beforeEach {
                            dict = result[1]
                        }

                        it("should have correct number of elements") {
                            expect(dict).to(haveCount(1))
                        }

                        describe("fake_key2") {
                            it("should have correct value") {
                                expect(dict["fake_key2"] as? String).to(equal("fake_value2"))
                            }
                        }
                    }
                }
            }

            context("when json data is incorrect") {
                beforeEach {
                    jsonData = Data()
                }

                it("should throw fatalError") {
                    expect { _ = jsonData.jsonArray }.to(throwAssertion())
                }
            }

            context("when json NOT contain array") {
                beforeEach {
                    let array = [
                        "fake_key1": "fake_value"
                    ]
                    jsonData = try! JSONSerialization.data(withJSONObject: array, options: [])
                }

                it("should throw fatalError") {
                    expect { _ = jsonData.jsonArray }.to(throwAssertion())
                }
            }
        }
    }

}
