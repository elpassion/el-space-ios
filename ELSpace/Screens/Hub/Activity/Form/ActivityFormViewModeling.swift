import RxSwift

protocol ActivityFormViewInputModeling {
    var performedAt: Observable<String> { get }
    var projectNames: Observable<[String]> { get }
    var projectSelected: Observable<String> { get }
    var projectInputHidden: Observable<Bool> { get }
    var initialHours: Observable<String> { get }
    var hoursInputHidden: Observable<Bool> { get }
    var initialComment: Observable<String> { get }
    var commentInputHidden: Observable<Bool> { get }
    var form: Observable<ActivityForm> { get }
}

protocol ActivityFormViewOutputModeling {
    var type: AnyObserver<ActivityType> { get }
    var date: AnyObserver<Date> { get }
    var projectPicked: AnyObserver<String> { get }
    var hours: AnyObserver<String> { get }
    var comment: AnyObserver<String> { get }
}
