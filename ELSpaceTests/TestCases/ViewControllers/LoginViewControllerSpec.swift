import Quick
import Nimble
import GoogleSignIn
import RxTest

@testable import ELSpace

class LoginViewControllerSpec: QuickSpec {

    override func spec() {
        describe("LoginViewController") {

            var sut: LoginViewController!
            var navigationController: UINavigationController!
            var viewControllerPresenterSpy: ViewControllerPresenterSpy!
            var googleUserManagerSpy: GoogleUserManagerSpy!

            afterEach {
                sut = nil
                navigationController = nil
                viewControllerPresenterSpy = nil
                googleUserManagerSpy = nil
            }

            context("when try to initialize with init coder") {
                it("should throw fatalError") {
                    expect { sut = LoginViewController(coder: NSCoder()) }.to(throwAssertion())
                }
            }

            context("after initialize") {
                beforeEach {
                    viewControllerPresenterSpy = ViewControllerPresenterSpy()
                    googleUserManagerSpy = GoogleUserManagerSpy()
                    sut = LoginViewController(googleUserManager: googleUserManagerSpy,
                                              alertFactory: AlertFactoryFake(),
                                              viewControllerPresenter: viewControllerPresenterSpy,
                                              googleUserMapper: GoogleUSerMapperFake())
                    navigationController = UINavigationController(rootViewController: sut)
                }

                describe("view") {
                    it("should be kind of LoginView") {
                        expect(sut.view as? LoginView).toNot(beNil())
                    }

                    context("when appear") {
                        beforeEach {
                            sut.viewWillAppear(true)
                        }

                        it("should set navigation bar hidden") {
                            expect(navigationController.isNavigationBarHidden).to(beTrue())
                        }
                    }
                }

                context("when viewWillAppear") {
                    beforeEach {
                        sut.viewWillAppear(true)
                    }

                    it("should set navigation bar to hidden") {
                        expect(navigationController.isNavigationBarHidden).to(beTrue())
                    }
                }

                it("should have correct preferredStatusBarStyle") {
                    expect(sut.preferredStatusBarStyle == .lightContent).to(beTrue())
                }

                context("when tap sign in button and sign in with success") {
                    var resultToken: String!

                    beforeEach {
                        sut.googleTooken = { token in
                            resultToken = token
                        }
                        googleUserManagerSpy.resultUser = GIDGoogleUser()
                        sut.loginView.loginButton.sendActions(for: .touchUpInside)
                    }

                    it("should sign in on correct view controller") {
                        expect(googleUserManagerSpy.viewController).to(equal(sut))
                    }

                    it("should get correct token") {
                        expect(resultToken).to(equal("fake_token"))
                    }
                }

                context("when tap sign in button and sign in with ValidationError emialFormat") {
                    beforeEach {
                        googleUserManagerSpy.resultError = EmailValidator.EmailValidationError.emailFormat
                        sut.loginView.loginButton.sendActions(for: .touchUpInside)
                    }

                    it("should present error on correct view controller") {
                        expect(viewControllerPresenterSpy.presenter).to(equal(sut))
                    }
                }

                context("when tap sign in button and sign in with ValidationError incorrectDomain") {
                    beforeEach {
                        googleUserManagerSpy.resultError = EmailValidator.EmailValidationError.incorrectDomain
                        sut.loginView.loginButton.sendActions(for: .touchUpInside)
                    }

                    it("should present error on correct view controller") {
                        expect(viewControllerPresenterSpy.presenter).to(equal(sut))
                    }
                }

                context("when tap sign in button and sign in with unkown error") {
                    beforeEach {
                        googleUserManagerSpy.resultError = NSError(domain: "fake_domain",
                                                                   code: 999,
                                                                   userInfo: nil)
                        sut.loginView.loginButton.sendActions(for: .touchUpInside)
                    }

                    it("should NOT present error") {
                        expect(viewControllerPresenterSpy.presenter).to(beNil())
                    }
                }
            }
        }
    }

}
