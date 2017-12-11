import Quick
import Nimble

@testable import ELSpace

class ActivityViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ActivityViewController") {

            var sut: ActivityViewController!

            it("should throw fatalError when initailize with coder") {
                expect { sut = ActivityViewController(coder: NSCoder()) }.to(throwAssertion())
            }
        }
    }

}
