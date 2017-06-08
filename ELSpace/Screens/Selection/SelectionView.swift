//
//  Created by Michał Czerniakowski on 08.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import Anchorage
import HexColors

class SelectionView: UIView {
    
    private let backgroundView = BackgroundGradientWithLogo()
    let hubButton = UIButton(frame: .zero)
    let debateButton = UIButton(frame: .zero)
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
