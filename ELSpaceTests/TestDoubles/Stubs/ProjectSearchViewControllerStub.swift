@testable import ELSpace
import UIKit
import RxSwift
import RxCocoa

class ProjectSearchViewControllerStub: UIViewController, ProjectSearchViewControlling {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    let stubbedSearchText = PublishSubject<String>()
    let stubbedDidSelectProject = PublishSubject<ProjectDTO>()
    var caughtSelectedId: Int?

    // MARK: ProjectSearchViewControlling

    let disposeBag = DisposeBag()

    let projectRelay = BehaviorRelay<[ProjectDTO]>(value: [])

    var searchText: Observable<String> {
        return stubbedSearchText.asObservable()
    }

    var didSelectProject: Observable<ProjectDTO> {
        return stubbedDidSelectProject.asObservable()
    }

    var selectedProjectIdObserver: AnyObserver<Int?> {
        return AnyObserver(onNext: { self.caughtSelectedId = $0 })
    }

}
