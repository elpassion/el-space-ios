//
//  Created by Michał Czerniakowski on 07.06.2017.
//Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import Pastel
import Anchorage

class BackgroundGradientWithLogo: UIView {

    private let gradientView = PastelView(frame: .zero)
    private let logoImageView = UIImageView(frame: .zero)

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init() {
        super.init(frame: .zero)
        configureBackgroundGradient()
        configureSubviews()
        configureAutolayout()
    }

    private func configureBackgroundGradient() {
        gradientView.startPastelPoint = .topLeft
        gradientView.endPastelPoint = .bottomRight
        gradientView.animationDuration = 3.5

        gradientView.setColors(gradientColors)
        gradientView.startAnimation()
    }

    private var gradientColors: [UIColor] {
        guard let color0 = UIColor(color: .blue17EAD9),
            let color1 = UIColor(color: .purple622774),
            let color2 = UIColor(color: .blue7177EA),
            let color3 = UIColor(color: .blue1BCEDF),
            let color4 = UIColor(color: .blue3BB2B8),
            let color5 = UIColor(color: .pinkF02FC2),
            let color6 = UIColor(color: .purple5B247A) else { fatalError("Could not create Colors") }

          return [color0, color1, color2, color3, color4, color5, color6]
    }

    private func configureSubviews() {
        logoImageView.image = #imageLiteral(resourceName: "asset_el_space_logo")

        addSubview(gradientView)
        addSubview(logoImageView)
    }

    private func configureAutolayout() {
        gradientView.edgeAnchors == self.edgeAnchors

        logoImageView.topAnchor == self.topAnchor + 40
        logoImageView.centerXAnchor == self.centerXAnchor
    }

}
