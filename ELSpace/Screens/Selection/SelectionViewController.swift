//
//  Created by Michał Czerniakowski on 08.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = SelectionView()
    }
    
    private var selectionView: SelectionView {
        guard let selectionView = view as? SelectionView else { fatalError("Expected SelectionView but got \(type(of: view))") }
        return selectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
    }
    
    private func configureSubviews() {
        selectionView.hubButton.addTarget(self, action: #selector(didTapHubButton), for: .touchUpInside)
        selectionView.debateButton.addTarget(self, action: #selector(didTapDebateButton), for: .touchUpInside)
    }
    
    func didTapHubButton() {
    }
    
    func didTapDebateButton(){
    }
}
