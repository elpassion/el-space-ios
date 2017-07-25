//
//  Created by Michał Czerniakowski on 08.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import Anchorage
import HexColors

class SelectionView: UIView {

    private let backgroundView = BackgroundGradientWithLogo()
    let hubButton = Button(frame: .zero)
    let debateButton = Button(frame: .zero)

    init() {
        super.init(frame: .zero)
        configureButtons()
        configureSubviews()
        configureAutolayout()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func configureButtons() {
        let hubButtonTitle = Localizable.hub_button_title()
        let debateButtonTitle = Localizable.debate_button_title()

        hubButton.setTitle(hubButtonTitle, for: .normal)
        debateButton.setTitle(debateButtonTitle, for: .normal)

        hubButton.backgroundColor = UIColor("AB9BFF")
        debateButton.backgroundColor = UIColor("4CC359")
    }

    private func configureSubviews() {
        addSubview(backgroundView)
        addSubview(hubButton)
        addSubview(debateButton)
    }

    private func configureAutolayout() {
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20

        backgroundView.edgeAnchors == self.edgeAnchors

        debateButton.heightAnchor == buttonHeight
        debateButton.bottomAnchor == self.bottomAnchor - buttonSpacing
        debateButton.horizontalAnchors == self.horizontalAnchors + buttonSpacing

        hubButton.heightAnchor == buttonHeight
        hubButton.bottomAnchor == debateButton.topAnchor - buttonSpacing
        hubButton.horizontalAnchors == self.horizontalAnchors + buttonSpacing
    }
}
