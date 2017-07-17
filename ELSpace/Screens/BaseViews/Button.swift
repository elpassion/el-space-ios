//
//  Created by Michał Czerniakowski on 05.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit

class Button: UIButton {

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        configureButtonLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureButtonLayout() {
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = R.font.sourceCodeProBold(size: 16.0)
        layer.cornerRadius = 4.0
        clipsToBounds = true
    }
}
