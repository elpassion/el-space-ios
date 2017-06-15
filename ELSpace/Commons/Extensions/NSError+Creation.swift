//
//  Created by Bartlomiej Guminiak on 12/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

extension NSError {
    
    static func googleConfiguration(description: String) -> Error {
        return NSError(domain: "Google Configuration \(description)", code: 0, userInfo: nil)
    }
    
    static func emailFormat() -> Error {
        return NSError(domain: "Email format", code: 0, userInfo: nil)
    }
    
    static func incorrectDomain() -> Error {
        return NSError(domain: "Incorrect email domain", code: 0, userInfo: nil)
    }
    
}
