//
//  Created by Michał Czerniakowski on 08.06.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit
import RxSwift

class SelectionViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    var debateButtonTapObservable: Observable<Void> {
        return selectionView.debateButton.rx.tap.asObservable()
    }

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

}
