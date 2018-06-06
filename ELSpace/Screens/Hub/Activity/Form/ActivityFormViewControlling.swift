import RxSwift

protocol ActivityFormViewControlling {
    var type: AnyObserver<ActivityType> { get }
    var form: Observable<ActivityForm> { get }
}
