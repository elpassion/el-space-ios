import UIKit
import RxSwift

class ActivityTypesViewController: UIViewController, ActivityTypesViewControlling {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ActivityTypesView()
    }
    // MARK: ActivityTypeViewControlling

    enum `Type` {
        case timeReport, vacation, dayOff, sickLeave, conference
    }

    var selected: Observable<ActivityTypesViewController.Type> {
        return Observable.never()
    }

    var select: AnyObserver<ActivityTypesViewController.Type> {
        return AnyObserver(eventHandler: { [weak self] in
            print($0)
        })
    }

    // MARK: Privates

    private var activityTypesView: ActivityTypesView! {
        return view as? ActivityTypesView
    }

    private func activityTypeView() -> ActivityTypeView {
        return ActivityTypeView()
    }

}
