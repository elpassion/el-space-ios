//
//  Created by Bartlomiej Guminiak on 12/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

protocol EmailValidating {

    func validate(email: String) throws
    func validate(email: String, with expectedDomain: String) throws

}

class EmailValidator: EmailValidating {

    enum EmailValidationError: String, Error {
        case emailFormat = "Email format"
        case incorrectDomain = "Incorrect domain"
    }

    func validate(email: String) throws {
        guard email.isValidEmail() else { throw EmailValidationError.emailFormat }
    }

    func validate(email: String, with expectedDomain: String) throws {
        guard email.emailDomain() == expectedDomain else { throw EmailValidationError.incorrectDomain }
    }

}
