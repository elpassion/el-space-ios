//
//  Created by Michał Czerniakowski on 31.05.2017.
//  Copyright © 2017 El Passion. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = MainView()
    }
    
    private var mainView: MainView {
        guard let mainView = view as? MainView else { fatalError("Expected LoginView but got \(type(of: view))") }
        return mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
    }

    private func configureSubviews(){
        view.backgroundColor = UIColor.red
    }
}

