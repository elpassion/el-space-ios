import Quick
import Nimble

@testable import ELSpace

class UIAlertControllerCreationSpec: QuickSpec {

    override func spec() {
        describe("UIAlertControllerCreation") {

            var sut: UIAlertController!

            context("when create alert controller") {
                beforeEach {
                    sut = UIAlertController.messageAlertViewController(with: "fake_message")
                }

                describe("alert controller") {
                    it("should have correct message") {
                        expect(sut.message).to(equal("fake_message"))
                    }

                    it("should have one action") {
                        expect(sut.actions).to(haveCount(1))
                    }

                    describe("action") {
                        it("should have correct title") {
                            expect(sut.actions[0].title).to(equal(Localizable.ok_label()))
                        }
                    }
                }
            }
        }
    }

}
