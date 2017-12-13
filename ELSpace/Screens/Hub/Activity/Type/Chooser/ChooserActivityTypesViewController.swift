import UIKit
import RxSwift

class ChooserActivityTypesViewController: UIViewController, ChooserActivityTypesViewControlling {

    init(viewModel: ChooserActivityTypesViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ChooserActivityTypesView()
    }

    // MARK: ActivityTypeViewControlling

    var selected: Observable<ActivityType> {
        return Observable.never()
    }

    var select: AnyObserver<ActivityType> {
        return AnyObserver(eventHandler: { [weak self] in
            print($0)
        })
    }

    // MARK: Privates

    private let viewModel: ChooserActivityTypesViewModeling

    private var activityTypesView: ChooserActivityTypesView! {
        return view as? ChooserActivityTypesView
    }

    private func activityTypeView() -> ChooserActivityTypesView {
        return ChooserActivityTypesView()
    }

}
