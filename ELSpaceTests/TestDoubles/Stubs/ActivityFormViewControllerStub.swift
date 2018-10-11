@testable import ELSpace
import UIKit
import RxSwift

class ActivityFormViewControllerStub: UIViewController, ActivityFormViewControlling {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    var caughtType: ReportType?
    var stubbedForm = PublishSubject<ActivityForm>()
    var stubbedProjectFieldSelected = PublishSubject<Int?>()
    var caughtDidSelectProjectName: String?

    // MARK: ActivityFormViewControlling

    var type: AnyObserver<ReportType> {
        return AnyObserver(onNext: { self.caughtType = $0 })
    }

    var form: Observable<ActivityForm> {
        return stubbedForm.asObservable()
    }

    var projectFieldSelected: Observable<Int?> {
        return stubbedProjectFieldSelected.asObservable()
    }

    var didSelectProject: AnyObserver<String> {
        return AnyObserver(onNext: { self.caughtDidSelectProjectName = $0 })
    }

}
