//
//  Created by Michał Czerniakowski on 05.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import Pastel
import Anchorage
import UIColor_Hex_Swift

class MainView: UIView {
    
    private let gradientView = PastelView(frame: .zero)
    
    init() {
        super.init(frame: .zero)
        configureBackground()
        configureLoginButton()
        configureSubviews()
        configureAutolayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func configureBackground(){
        gradientView.startPastelPoint = .topLeft
        gradientView.endPastelPoint = .bottomRight
        
        gradientView.animationDuration = 5.0
        
        gradientView.setColors([
            UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
            UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
            UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
            UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
            UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
            UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
            UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        gradientView.startAnimation()
    }
    
    private func configureLoginButton(){
    }
    
    private func configureSubviews(){
        self.addSubview(gradientView)
    }


    private func configureAutolayout(){
        gradientView.edgeAnchors == self.edgeAnchors
    }
}
