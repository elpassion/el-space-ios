//
//  Created by Bartlomiej on 12/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import Quick
import Nimble

@testable
import ELSpace

class GoogleUserProviderSpec: QuickSpec {

    override func spec() {
        context("GoogleUserProvider") {

            var sut: GoogleUserProvider!
            var googleSignInMock: GoogleSignInMock!

            beforeEach {
                googleSignInMock = GoogleSignInMock()
                sut = GoogleUserProvider(googleSignIn: googleSignInMock,
                                         hostedDomain: "abc@gmail.com")
            }

            afterEach {
                googleSignInMock = nil
                sut = nil
            }

            it("should configure GoogleSignIn with correct domain") {
                expect(googleSignInMock.hostedDomain).to(equal("abc@gmail.com"))
            }

            it("should be GoogleSignIn delegate") {
                expect(googleSignInMock.delegate === sut).to(beTrue())
            }

            context("when call signIn") {
                var fakeViewController: UIViewController!

                beforeEach {
                    fakeViewController = UIViewController()
                    sut.signIn(on: fakeViewController)
                }

                it("should fakeViewController be uiDelegate") {
                    expect(googleSignInMock.uiDelegate === fakeViewController).to(beTrue())
                }

                it("should call signIn method") {
                    expect(googleSignInMock.signInCalled).to(beTrue())
                }
            }

            context("when googleSignIn has AuthInKeychain") {
                beforeEach {
                    googleSignInMock.authInKeychainResult = true
                }

                context("when call autoSignIn") {
                    beforeEach {
                        sut.autoSignIn()
                    }

                    describe("googleSignIn") {
                        it("should call signInSilently") {
                            expect(googleSignInMock.didCallSignInSilently).to(beTrue())
                        }
                    }
                }
            }

            context("when googleSignIn has NOT AuthInKeychain") {
                beforeEach {
                    googleSignInMock.authInKeychainResult = false
                }

                context("when call autoSignIn") {
                    beforeEach {
                        sut.autoSignIn()
                    }

                    describe("googleSignIn") {
                        it("should NOT call signInSilently") {
                            expect(googleSignInMock.didCallSignInSilently).to(beFalse())
                        }
                    }
                }
            }
        }
    }

}
