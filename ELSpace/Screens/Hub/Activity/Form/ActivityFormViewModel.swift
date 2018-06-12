import Foundation
import RxSwift
import RxCocoa

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
    var type: AnyObserver<ReportType> { get }
    var selectProject: AnyObserver<String> { get }
    var updateHours: AnyObserver<String> { get }
    var updateComment: AnyObserver<String> { get }
}

class ActivityFormViewModel: ActivityFormViewInputModeling, ActivityFormViewOutputModeling {

    init(date: Date, report: ReportDTO?, projectScope: [ProjectDTO]) {
        self.date = date
        self.report = report
        self.projectScope = projectScope
        projectNamesSubject = BehaviorSubject<[String]>(value: projectScope.map { $0.name })
        projectSelectedSubject = BehaviorSubject<String>(value: projectScope.filter { $0.id == report?.projectId }.first?.name ?? "")
        updateHoursSubject = BehaviorSubject<String>(value: "\(report?.value ?? "")")
        updateCommentSubject = BehaviorSubject<String>(value: report?.comment ?? "")
        if let type = report?.reportType, let reportType = ReportType(rawValue: type)  {
            self.type.onNext(reportType)
        }
    }

    // MARK: - ActivityFormViewInputModeling

    var performedAt: Observable<String> {
        return Observable.empty()
        // TODO
//        return Observable.of(report.performedAt)
    }

    var projectNames: Observable<[String]> {
        return projectNamesSubject.asObservable()
    }

    var projectSelected: Observable<String> {
        return projectSelectedSubject.asObservable()
    }

    var hours: Observable<String> {
        return updateHoursSubject.asObservable()
    }

    var comment: Observable<String> {
        return updateCommentSubject.asObservable()
    }

    var projectInputHidden: Observable<Bool> {
        return projectInputHiddenRelay.asObservable()
    }

    var hoursInputHidden: Observable<Bool> {
        return hoursInputHiddenRelay.asObservable()
    }

    var commentInputHidden: Observable<Bool> {
        return commentInputHiddenRelay.asObservable()
    }

    var form: Observable<ActivityForm> {
        return Observable.combineLatest(projectSelected, updateHoursSubject, updateCommentSubject)
            .map { ActivityForm(project: $0.0, hours: Double(from: $0.1), comment: $0.2) }
    }

    // MARK: - ActivityFormViewOutputModeling

    var type: AnyObserver<ReportType> {
        return AnyObserver(eventHandler: { [weak self]  in
            let isProjectInputHidden = $0.element != .normal
            let isHoursInputHidden = !($0.element == .normal || $0.element == .paidVacations)
            let isCommentInputHidden = $0.element != .normal

            self?.projectInputHiddenRelay.accept(isProjectInputHidden)
            self?.hoursInputHiddenRelay.accept(isHoursInputHidden)
            self?.commentInputHiddenRelay.accept(isCommentInputHidden)
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

    private let date: Date
    private let report: ReportDTO?
    private let projectScope: [ProjectDTO]
    private let projectNamesSubject: BehaviorSubject<[String]>
    private let projectSelectedSubject: BehaviorSubject<String>
    private let projectInputHiddenRelay = BehaviorRelay(value: false)
    private let hoursInputHiddenRelay = BehaviorRelay(value: false)
    private let commentInputHiddenRelay = BehaviorRelay(value: false)
    private let updateHoursSubject: BehaviorSubject<String>
    private let updateCommentSubject: BehaviorSubject<String>

}
