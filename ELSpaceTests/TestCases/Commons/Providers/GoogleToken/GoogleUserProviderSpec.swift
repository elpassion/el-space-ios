//
//  Created by Bartlomiej on 12/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import Quick
import Nimble
import RxBlocking

@testable
import ELSpace

class GoogleUserProviderSpec: QuickSpec {
    override func spec() {
        context("GoogleUserProvider") {
            
            var sut: GoogleUserProvider!
            var googleSignInMock: GoogleSignInMock!
            
            beforeEach {
                googleSignInMock = GoogleSignInMock()
                sut = GoogleUserProvider(googleSignIn: googleSignInMock)
                sut.configure(with: "abc@gmail.com")
            }
            
            afterEach {
                googleSignInMock = nil
                sut = nil
            }
            
            describe("proper hostedDomain") {
                
                it("should be elpassion.pl") {
                    expect(googleSignInMock.hostedDomain) == "abc@gmail.com"
                }
                
            }
            
            describe("proper delegate") {
                
                it("should be sut object") {
                    expect(sut) === googleSignInMock.delegate
                }
                
            }

            describe("signIn method call") {
                
                beforeEach {
                    let viewController = UIViewController()
                    let _ = sut.signIn(on: viewController)
                }
                
                it("should call signIn method on googleSignIn dependency") {
                    expect(googleSignInMock.signInCalled) == true
                }
                
            }
            
            describe("proper uiDelegate") {

                var viewController: UIViewController!
                
                beforeEach {
                    viewController = UIViewController()
                    let _ = sut.signIn(on: viewController)
                }
                
                it("should set proper uiDelegate") {
                    expect(viewController) === googleSignInMock.uiDelegate
                }
                
            }
            
        }
    }
}
