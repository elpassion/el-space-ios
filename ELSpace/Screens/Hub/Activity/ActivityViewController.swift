import UIKit

class ActivityViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New activity"
        navigationItem.rightBarButtonItem = addBarButton
    }

    // MARK: - Private

    private let addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)

}
