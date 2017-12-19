import RxSwift

protocol ActivityFormViewControlling {
    var type: AnyObserver<ActivityType> { get }
}
