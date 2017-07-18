//
//  Created by Michał Czerniakowski on 08.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit

protocol SelectionViewControllerDelegate: class {
    
    func debateAction(vc: SelectionViewController)
    
}

class SelectionViewController: UIViewController {

    weak var delegate: SelectionViewControllerDelegate?
    
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
        selectionView.debateButton.addTarget(self, action: #selector(didTapDebateButton), for: .touchUpInside)
    }
    
    func didTapDebateButton(){
        delegate?.debateAction(vc: self)
    }

}
