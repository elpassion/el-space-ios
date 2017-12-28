import UIKit
import RxSwift

protocol ActivityViewControlling {
    var addAction: Observable<Void> { get }
    var isLoading: AnyObserver<Bool> { get }
}

class ActivityViewController: UIViewController, ActivityViewControlling {

    init(chooserActivityTypeViewController: UIViewController & ChooserActivityTypesViewControlling) {
        self.chooserActivityTypeViewController = chooserActivityTypeViewController
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View

    override func loadView() {
        view = ActivityView()
        loadingIndicator = LoadingIndicator(superView: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = NavigationItemSubviews.label
        navigationItem.rightBarButtonItem = addBarButton
        configureChooserType()
    }

    private let addBarButton = NavigationItemSubviews.addBarButton
    private var loadingIndicator: LoadingIndicator?

    // MARK: - ActivityViewControlling

    var addAction: Observable<Void> {
        return addBarButton.rx.tap.asObservable()
    }

    var isLoading: AnyObserver<Bool> {
        return AnyObserver(onNext: { [weak self] in self?.loadingIndicator?.loading($0) })
    }

    // MARK: - Private

    private let chooserActivityTypeViewController: UIViewController & ChooserActivityTypesViewControlling

    private var activityView: ActivityView! {
        return view as? ActivityView
    }

    private func configureChooserType() {
        addChildViewController(chooserActivityTypeViewController)
        chooserActivityTypeViewController.didMove(toParentViewController: self)
        activityView.activityTypeView = chooserActivityTypeViewController.view
    }

}

private extension ActivityViewController {

    struct NavigationItemSubviews {
        static var label: UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont(name: "Gotham-Book", size: 17)
            label.textColor = .white
            label.text = "New activity"
            return label
        }

        static var addBarButton: UIBarButtonItem {
            let barButton = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)
            barButton.setTitleTextAttributes([
                NSAttributedStringKey.font: UIFont(name: "Gotham-Book", size: 17) as Any
            ], for: .normal)
            barButton.setTitleTextAttributes([
                NSAttributedStringKey.font: UIFont(name: "Gotham-Book", size: 17) as Any
            ], for: .highlighted)
            return barButton
        }
    }

}
