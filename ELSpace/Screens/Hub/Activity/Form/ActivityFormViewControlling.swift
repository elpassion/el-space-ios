import RxSwift

protocol ActivityFormViewControlling {
    var type: AnyObserver<ActivityType> { get }
    var date: AnyObserver<Date> { get }
    var form: Observable<ActivityForm> { get }
}
