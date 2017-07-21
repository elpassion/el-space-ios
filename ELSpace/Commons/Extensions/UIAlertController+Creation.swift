//
//  Created by Bartlomiej Guminiak on 14/06/2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit

extension UIAlertController {

    class func messageAlertViewController(with message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: R.string.localizable.ok_label(), style: .default, handler: nil)
        alert.addAction(okAction)

        return alert
    }

}
