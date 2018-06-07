import Foundation
import RxSwift

protocol ActivityFormViewInputModeling {
    var performedAt: Observable<String> { get }
    var projectNames: Observable<[String]> { get }
    var projectSelected: Observable<String> { get }
    var projectInputHidden: Observable<Bool> { get }
    var hours: Observable<String> { get }
    var hoursInputHidden: Observable<Bool> { get }
    var comment: Observable<String> { get }
    var commentInputHidden: Observable<Bool> { get }
    var form: Observable<ActivityForm> { get }
}

protocol ActivityFormViewOutputModeling {
    var type: AnyObserver<ActivityType> { get }
    var selectProject: AnyObserver<String> { get }
    var updateHours: AnyObserver<String> { get }
    var updateComment: AnyObserver<String> { get }
}

class ActivityFormViewModel: ActivityFormViewInputModeling, ActivityFormViewOutputModeling {

    init(report: ReportDTO, projectScope: [ProjectDTO]) {
        self.report = report
        self.projectScope = projectScope
        projectNamesSubject = BehaviorSubject<[String]>(value: projectScope.map { $0.name })
        projectSelectedSubject = BehaviorSubject<String>(value: projectScope.filter { $0.id == report.projectId }.first?.name ?? "")
        updateHoursSubject = BehaviorSubject<String>(value: "\(report.value)")
        updateCommentSubject = BehaviorSubject<String>(value: report.comment ?? "")
    }

    // MARK: - ActivityFormViewInputModeling

    var performedAt: Observable<String> {
        return Observable.of(report.performedAt)
    }

    var projectNames: Observable<[String]> {
        return projectNamesSubject.asObservable()
    }

    var projectSelected: Observable<String> {
        return projectSelectedSubject.asObservable()
    }

    var projectInputHidden: Observable<Bool> {
        return projectInputHiddenSubject.asObservable()
    }

    var hours: Observable<String> {
        return updateHoursSubject.asObservable()
    }

    var hoursInputHidden: Observable<Bool> {
        return hoursInputHiddenSubject.asObservable()
    }

    var comment: Observable<String> {
        return updateCommentSubject.asObservable()
    }

    var commentInputHidden: Observable<Bool> {
        return commentInputHiddenSubject.asObservable()
    }

    var form: Observable<ActivityForm> {
        return Observable.combineLatest(projectSelected, updateHoursSubject, updateCommentSubject)
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

    var selectProject: AnyObserver<String> {
        return projectSelectedSubject.asObserver()
    }

    var updateHours: AnyObserver<String> {
        return updateHoursSubject.asObserver()
    }

    var updateComment: AnyObserver<String> {
        return updateCommentSubject.asObserver()
    }

    // MARK: - Privates

    private let report: ReportDTO
    private let projectScope: [ProjectDTO]
    private let projectNamesSubject: BehaviorSubject<[String]>
    private let projectInputHiddenSubject = PublishSubject<Bool>()
    private let projectSelectedSubject: BehaviorSubject<String>
    private let hoursInputHiddenSubject = PublishSubject<Bool>()
    private let commentInputHiddenSubject = PublishSubject<Bool>()
    private let updateHoursSubject: BehaviorSubject<String>
    private let updateCommentSubject: BehaviorSubject<String>

}
