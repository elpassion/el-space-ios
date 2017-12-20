import RxSwift

class ActivityFormViewModel: ActivityFormViewInputModeling, ActivityFormViewOutputModeling {

    // MARK: - ActivityFormViewInputModeling

    var performedAt: Observable<String> {
        return Observable.of("Mon, 5th Sep 2016")
    }

    var projectSelected: Observable<String> {
        return Observable.of("Slack Time")
    }

    var projectInputHidden: Observable<Bool> {
        return projectInputHiddenSubject.asObservable()
    }

    var hours: Observable<String> {
        return Observable.of("8")
    }

    var hoursInputHidden: Observable<Bool> {
        return hoursInputHiddenSubject.asObservable()
    }

    var comment: Observable<String> {
        return Observable.of("ElSpace report form implementation")
    }

    var commentInputHidden: Observable<Bool> {
        return commentInputHiddenSubject.asObservable()
    }

    var showProjectPicker: Observable<[String]> {
        return Observable.of([])
    }

    var closeProjectPicker: Observable<Void> {
        return Observable.never()
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

    var projectIndexPicked: AnyObserver<Int> {
        return AnyObserver(eventHandler: { [weak self] _ in print() })
    }

    // MARK: - Privates

    private let projectInputHiddenSubject = PublishSubject<Bool>()
    private let hoursInputHiddenSubject = PublishSubject<Bool>()
    private let commentInputHiddenSubject = PublishSubject<Bool>()

}
