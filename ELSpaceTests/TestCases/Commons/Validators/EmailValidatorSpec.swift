import Quick
import Nimble
import RxSwift
import RxTest

@testable import ELSpace

class EmailValidatorSpec: QuickSpec {

    override func spec() {
        describe("EmailValidator") {
            var sut: EmailValidator!
            var scheduler: TestScheduler!
            var observer: TestableObserver<Error>!

            beforeEach {
                sut = EmailValidator()
                scheduler = TestScheduler(initialClock: 0)
                observer = scheduler.createObserver(Error.self)
            }

            afterEach {
                sut = nil
                scheduler = nil
                observer = nil
            }

            context("when validate good email") {
                var result: Bool!

                beforeEach {
                    result = sut.validateEmail(email: "abc@elpassion.pl", hostedDomain: "elpassion.pl")
                }

                it("should validation be true") {
                    expect(result).to(beTrue())
                }
            }

            context("when validate email with incorrect format") {
                var result: Bool!

                beforeEach {
                    _ = sut.error.subscribe(observer)
                    result = sut.validateEmail(email: "aaaaaa", hostedDomain: "gmail.com")
                }

                it("should validation NOT be true") {
                    expect(result).to(beFalse())
                }

                describe("error") {
                    var emailValidationError: EmailValidator.EmailValidationError!

                    beforeEach {
                        let error = observer.events.first!.value.element!
                        emailValidationError = error as? EmailValidator.EmailValidationError
                    }

                    it("should emit one event") {
                        expect(observer.events).to(haveCount(1))
                    }

                    it("should be 'emailFormat' error") {
                        expect(emailValidationError == .emailFormat).to(beTrue())
                    }
                }
            }

            context("when validate email with incorrect domain") {
                var result: Bool!

                beforeEach {
                    _ = sut.error.subscribe(observer)
                    result = sut.validateEmail(email: "aaaaaa@wp.pl", hostedDomain: "gmail.com")
                }

                it("should validation NOT be true") {
                    expect(result).to(beFalse())
                }

                describe("error") {
                    var emailValidationError: EmailValidator.EmailValidationError!

                    beforeEach {
                        let error = observer.events.first!.value.element!
                        emailValidationError = error as? EmailValidator.EmailValidationError
                    }

                    it("should emit one event") {
                        expect(observer.events).to(haveCount(1))
                    }

                    it("should be 'emailFormat' error") {
                        expect(emailValidationError == .incorrectDomain).to(beTrue())
                    }
                }
            }
        }
    }

}
