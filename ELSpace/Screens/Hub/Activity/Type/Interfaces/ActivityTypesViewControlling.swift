import RxSwift

protocol ActivityTypesViewControlling {
    var selected: Observable<ActivityTypesViewController.Type> { get }
    var select: AnyObserver<ActivityTypesViewController.Type> { get }
}
