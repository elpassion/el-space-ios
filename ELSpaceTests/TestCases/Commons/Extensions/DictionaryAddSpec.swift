import Quick
import Nimble

@testable import ELSpace

class DictionaryAddSpec: QuickSpec {

    override func spec() {
        describe("DictionaryAdd") {
            var dict1: [String: String]!
            var dict2: [String: String]!

            afterEach {
                dict1 = nil
                dict2 = nil
            }

            context("when add two differen dictionaries") {
                beforeEach {
                    dict1 = ["fake_key1": "fake_value1"]
                    dict2 = ["fake_key2": "fake_value2"]
                    dict1.add(dict: dict2)
                }

                it("dict1 should have correct number of elements") {
                    expect(dict1).to(haveCount(2))
                }

                it("'fake_key1' should have correct value") {
                    expect(dict1["fake_key1"]).to(equal("fake_value1"))
                }

                it("'fake_key2' should have correct value") {
                    expect(dict1["fake_key2"]).to(equal("fake_value2"))
                }
            }

            context("when add two partly different dictionaries") {
                beforeEach {
                    dict1 = [
                        "fake_key1": "fake_value1",
                        "fake_key3": "fake_value_to_update"
                    ]
                    dict2 = [
                        "fake_key2": "fake_value2",
                        "fake_key3": "fake_value_updated"
                    ]
                    dict1.add(dict: dict2)
                }

                it("dict1 should have correct number of elements") {
                    expect(dict1).to(haveCount(3))
                }

                it("'fake_key1' should have correct value") {
                    expect(dict1["fake_key1"]).to(equal("fake_value1"))
                }

                it("'fake_key2' should have correct value") {
                    expect(dict1["fake_key2"]).to(equal("fake_value2"))
                }

                it("'fake_key3' should have correct value") {
                    expect(dict1["fake_key3"]).to(equal("fake_value_updated"))
                }
            }

            context("when add two this same dictionaries") {
                beforeEach {
                    dict1 = [ "fake_key1": "fake_value1" ]
                    dict2 = [ "fake_key1": "fake_value1" ]
                    dict1.add(dict: dict2)
                }

                it("dict1 should have correct number of elements") {
                    expect(dict1).to(haveCount(1))
                }

                it("'fake_key1' should have correct value") {
                    expect(dict1["fake_key1"]).to(equal("fake_value1"))
                }
            }
        }
    }

}
