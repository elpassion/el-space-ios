import RxSwift

class ActivityFormViewModel: ActivityFormViewInputModeling, ActivityFormViewOutputModeling {

    init() {
        let projects = ["Project 1", "Project 2"]
        projectNames = Observable.of(projects)
        projectSelectedSubject = BehaviorSubject<String>(value: projects.first!)
        hoursSubject = BehaviorSubject<String>(value: "8")
        commentSubject = BehaviorSubject<String>(value: "ElSpace report form implementation")
    }

    // MARK: - ActivityFormViewInputModeling

    var performedAt: Observable<String> {
        return performedAtSubject.asObservable().map { $0.description }
    }

    let projectNames: Observable<[String]>

    var projectSelected: Observable<String> {
        return projectSelectedSubject.asObservable()
    }

    var projectInputHidden: Observable<Bool> {
        return projectInputHiddenSubject.asObservable()
    }

    var initialHours: Observable<String> {
        return hoursSubject.asObservable()
    }

    var hoursInputHidden: Observable<Bool> {
        return hoursInputHiddenSubject.asObservable()
    }

    var initialComment: Observable<String> {
        return commentSubject.asObservable()
    }

    var commentInputHidden: Observable<Bool> {
        return commentInputHiddenSubject.asObservable()
    }

    var form: Observable<ActivityForm> {
        return Observable.combineLatest(projectSelected, hoursSubject, commentSubject)
            .map { ActivityForm(project: $0.0, hours: Double(from: $0.1), comment: $0.2) }
    }

    // MARK: - ActivityFormViewOutputModeling

    var type: AnyObserver<ActivityType> {
        return AnyObserver(eventHandler: { [weak self]  in
            let isProjectInputHidden = $0.element != .timeReport
            let isHoursInputHidden = !($0.element == .timeReport || $0.element == .vacation)
            let isCommentInputHidden = $0.element != .timeReport

            self?.projectInputHiddenSubject.onNext(isProjectInputHidden)
            self?.hoursInputHiddenSubject.onNext(isHoursInputHidden)
            self?.commentInputHiddenSubject.onNext(isCommentInputHidden)
        })
    }

    var date: AnyObserver<Date> {
        return performedAtSubject.asObserver()
    }

    var projectPicked: AnyObserver<String> {
        return projectSelectedSubject.asObserver()
    }

    var hours: AnyObserver<String> {
        return hoursSubject.asObserver()
    }

    var comment: AnyObserver<String> {
        return commentSubject.asObserver()
    }

    // MARK: - Privates

    private let performedAtSubject = PublishSubject<Date>()
    private let projectInputHiddenSubject = PublishSubject<Bool>()
    private let hoursInputHiddenSubject = PublishSubject<Bool>()
    private let commentInputHiddenSubject = PublishSubject<Bool>()
    private let projectSelectedSubject: BehaviorSubject<String>
    private let hoursSubject: BehaviorSubject<String>
    private let commentSubject: BehaviorSubject<String>

}
