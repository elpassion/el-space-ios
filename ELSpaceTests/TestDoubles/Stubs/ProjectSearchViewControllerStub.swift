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

    // MARK: ProjectSearchViewControlling

    let disposeBag = DisposeBag()

    let projectRelay = BehaviorRelay<[ProjectDTO]>(value: [])

    var searchText: Observable<String> {
        return stubbedSearchText.asObservable()
    }

    var didSelectProject: Observable<ProjectDTO> {
        return stubbedDidSelectProject.asObservable()
    }

}
