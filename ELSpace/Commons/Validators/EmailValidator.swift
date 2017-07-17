//
//  Created by Bartlomiej Guminiak on 12/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

protocol EmailValidating {

    func validate(email: String) throws
    func validate(email: String, with expectedDomain: String) throws

}

class EmailValidator: EmailValidating {

    func validate(email: String) throws {
        guard email.isValidEmail() else { throw NSError.emailFormat() }
    }

    func validate(email: String, with expectedDomain: String) throws {
        guard email.emailDomain() == expectedDomain else { throw NSError.incorrectDomain() }
    }

}
