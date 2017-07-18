//
//  Created by Bartlomiej Guminiak on 14/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import GoogleSignIn
import RxSwift

extension ObservableType where E == GIDGoogleUser {

    func validate(with validator: EmailValidating, expectedDomain: String) -> Observable<E> {
        return filter { user in
            try validator.validate(email: user.profile.email)
            try validator.validate(email: user.profile.email, with: expectedDomain)
            return true
        }
    }

}
