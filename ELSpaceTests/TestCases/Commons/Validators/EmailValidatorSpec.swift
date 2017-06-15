//
//  Created by Bartlomiej Guminiak on 12/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import Quick
import Nimble

@testable
import ELSpace

class EmailValidatorSpec: QuickSpec {
    override func spec() {
        context("EmailValidator") {
            
            var sut: EmailValidator!
            
            beforeEach {
                sut = EmailValidator()
            }
            
            afterEach {
                sut = nil
            }
            
            describe("validate email format") {
                
                it("should approve email format") {
                    do {
                        try sut.validate(email: "abc@gmail.com")
                        XCTAssert(true)
                    } catch {
                        XCTFail("improper email validation")
                    }
                }
                
                it("should throw email format error") {
                    do {
                        try sut.validate(email: "abcgmail.com")
                        XCTFail("improper email validation")
                    } catch {
                        XCTAssert(true)
                    }
                }
            }
            
            describe("validate email domain") {
                
                it("should approve email domain") {
                    do {
                        try sut.validate(email: "abc@elpassion.pl", with: "elpassion.pl")
                        XCTAssert(true)
                    } catch {
                        XCTFail("improper email domain validation")
                    }
                }
                
                it("should throw email domain error") {
                    do {
                        try sut.validate(email: "abc@elpassion.pl", with: "elpassion.eu")
                        XCTFail("improper email domain validation")
                    } catch {
                        XCTAssert(true)
                    }
                }
            }
            
        }
    }
}
