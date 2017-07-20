import Quick
import Nimble
import RxTest

@testable import ELSpace

class GoogleUserManagerSpec: QuickSpec {

    override func spec() {
        describe("GoogleUserManager") {

            var sut: GoogleUserManager!
            var googleUserProviderSpy: GoogleUserProviderSpy!
            var scheduler: TestScheduler!
            var observer: TestableObserver<GIDGoogleUser>!

            afterEach {
                sut = nil
                googleUserProviderSpy = nil
                scheduler = nil
                observer = nil
            }

            context("when initialize with uncorect domain") {
                var fakeGoogleUser: GIDGoogleUser!

                beforeEach {
                    scheduler = TestScheduler(initialClock: 0)
                    observer = scheduler.createObserver(GIDGoogleUser.self)
                    googleUserProviderSpy = GoogleUserProviderSpy()
                    sut = GoogleUserManager(googleUserProvider: googleUserProviderSpy,
                                            googleUserValidator: GoogleUserValidatorStub(),
                                            hostedDomain: "abc@gmail.com")
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
            }
        }
    }

}
