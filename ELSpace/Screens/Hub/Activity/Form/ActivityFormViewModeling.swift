import RxSwift

protocol ActivityFormViewInputModeling {
    var performedAt: Observable<String> { get }
    var projectSelected: Observable<String> { get }
    var projectInputHidden: Observable<Bool> { get }
    var hours: Observable<String> { get }
    var hoursInputHidden: Observable<Bool> { get }
    var comment: Observable<String> { get }
    var commentInputHidden: Observable<Bool> { get }
    var showProjectPicker: Observable<[String]> { get }
    var closeProjectPicker: Observable<Void> { get }
}

protocol ActivityFormViewOutputModeling {
    var type: Observable<ActivityType> { get }
    var projectIndexPicked: AnyObserver<Int> { get }
}
