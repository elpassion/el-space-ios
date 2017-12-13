import RxSwift

protocol ChooserActivityTypesViewControlling {
    var selected: Observable<ActivityType> { get }
    var select: AnyObserver<ActivityType> { get }
}
