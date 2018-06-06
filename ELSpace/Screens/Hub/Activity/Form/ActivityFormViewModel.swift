import Foundation
import RxSwift

class ActivityFormViewModel: ActivityFormViewInputModeling, ActivityFormViewOutputModeling {

    init(report: ReportDTO, projectScope: [ProjectDTO]) {
        self.report = report
        self.projectScope = projectScope
        projectNamesSubject = BehaviorSubject<[String]>(value: projectScope.map { $0.name })
        projectSelectedSubject = BehaviorSubject<String>(value: "Avenue")
        updateHoursSubject = BehaviorSubject<String>(value: "\(report.value)")
        updateCommentSubject = BehaviorSubject<String>(value: report.comment!)
    }

    // MARK: - ActivityFormViewInputModeling

    var performedAt: Observable<String> {
        return performedAtSubject.asObservable()
            .map { date -> String in
                let dateFormatter = DateFormatter.activityFormatter
                return dateFormatter.string(from: date)
            }
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

    var date: AnyObserver<Date> {
        return performedAtSubject.asObserver()
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
    private let performedAtSubject = PublishSubject<Date>()
    private let projectNamesSubject: BehaviorSubject<[String]>
    private let projectInputHiddenSubject = PublishSubject<Bool>()
    private let projectSelectedSubject: BehaviorSubject<String>
    private let hoursInputHiddenSubject = PublishSubject<Bool>()
    private let commentInputHiddenSubject = PublishSubject<Bool>()
    private let updateHoursSubject: BehaviorSubject<String>
    private let updateCommentSubject: BehaviorSubject<String>

}
