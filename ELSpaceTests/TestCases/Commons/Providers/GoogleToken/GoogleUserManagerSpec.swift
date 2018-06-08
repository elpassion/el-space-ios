import Quick
import Nimble
import RxTest
import GoogleSignIn

@testable import ELSpace

class GoogleUserManagerSpec: QuickSpec {

    override func spec() {
        describe("GoogleUserManager") {

            var sut: GoogleUserManager!
            var googleUserProviderSpy: GoogleUserProviderSpy!
            var googleUserValidatorStub: GoogleUserValidatorSpy!
            var scheduler: TestScheduler!
            var observer: TestableObserver<GIDGoogleUser>!

            afterEach {
                sut = nil
                googleUserProviderSpy = nil
                googleUserValidatorStub = nil
                scheduler = nil
                observer = nil
            }

            context("when initialize with uncorect domain") {
                var fakeGoogleUser: GIDGoogleUser!

                beforeEach {
                    scheduler = TestScheduler(initialClock: 0)
                    observer = scheduler.createObserver(GIDGoogleUser.self)
                    googleUserProviderSpy = GoogleUserProviderSpy()
                    googleUserValidatorStub = GoogleUserValidatorSpy()
                    sut = GoogleUserManager(googleUserProvider: googleUserProviderSpy,
                                            googleUserValidator: googleUserValidatorStub,
                                            hostedDomain: "abc@gmail.com")
                }

                context("when call autoSignIn") {
                    beforeEach {
                        sut.autoSignIn()
                    }

                    describe("googleUserProvider") {
                        it("should call autoSignIn") {
                            expect(googleUserProviderSpy.didCallAutoSignIn).to(beTrue())
                        }
                    }
                }

                context("when signIn") {
                    var fakeViewController: UIViewController!

                    beforeEach {
                        _ = sut.validationSuccess.subscribe(observer)
                        fakeViewController = UIViewController()
                        fakeGoogleUser = GIDGoogleUser()
                        googleUserProviderSpy.resultUser = fakeGoogleUser
                        sut.signIn(on: fakeViewController)
                    }

                    it("should call signIn") {
                        expect(googleUserProviderSpy.didSignIn).to(beTrue())
                    }

                    it("should signIn on correct ViewController") {
                        expect(googleUserProviderSpy.didSignInOnViewController === fakeViewController).to(beTrue())
                    }

                    describe("validationSuccess") {
                        var resultUser: GIDGoogleUser!

                        beforeEach {
                            resultUser = observer.events.first!.value.element!
                        }

                        it("should emit one event") {
                            expect(observer.events).to(haveCount(1))
                        }

                        it("should emit correct user") {
                            expect(fakeGoogleUser === resultUser).to(beTrue())
                        }
                    }
                }

                context("when signIn") {
                    var fakeViewController: UIViewController!

                    beforeEach {
                        _ = sut.validationSuccess.subscribe(observer)
                        fakeViewController = UIViewController()
                        fakeGoogleUser = GIDGoogleUser()
                        googleUserProviderSpy.resultUser = fakeGoogleUser
                        sut.signIn(on: fakeViewController)
                    }

                    it("should call signIn") {
                        expect(googleUserProviderSpy.didSignIn).to(beTrue())
                    }

                    it("should signIn on correct ViewController") {
                        expect(googleUserProviderSpy.didSignInOnViewController === fakeViewController).to(beTrue())
                    }

                }

                context("when ValidationError error occurs") {
                    beforeEach {
                        googleUserValidatorStub.resultError = EmailValidator.EmailValidationError.emailFormat
                    }

                    it("should disconnect") {
                        expect(googleUserProviderSpy.didDisconnect).to(beTrue())
                    }
                }

                context("when Error occurs") {
                    beforeEach {
                        googleUserValidatorStub.resultError = NSError(domain: "fake_domain", code: 0, userInfo: nil)
                    }

                    it("should NOT disconnect") {
                        expect(googleUserProviderSpy.didDisconnect).to(beFalse())
                    }
                }
            }
        }
    }

}
