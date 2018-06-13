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

    init(activityType: ActivityType, projectScope: [ProjectDTO]) {
        self.activityType = activityType
        self.projectScope = projectScope
        configure()
    }

    // MARK: - ActivityFormViewInputModeling

    var performedAt: Observable<String> {
        switch activityType {
        case .report(let report): return Observable.of(report.performedAt)
        case .new(let date): return Observable.of(date.description)
        }
    }

    var projectNames: Observable<[String]> {
        return projectNamesRelay.asObservable()
    }

    var projectSelected: Observable<String> {
        return projectSelectedRelay.asObservable()
    }

    var hours: Observable<String> {
        return updateHoursRelay.asObservable()
    }

    var comment: Observable<String> {
        return updateCommentRelay.asObservable()
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
        return Observable.combineLatest(projectSelected, updateHoursRelay, updateCommentRelay)
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
        return AnyObserver(onNext: { [weak self] in self?.projectSelectedRelay.accept($0) })
    }

    var updateHours: AnyObserver<String> {
        return AnyObserver(onNext: { [weak self] in self?.updateHoursRelay.accept($0) })
    }

    var updateComment: AnyObserver<String> {
        return AnyObserver(onNext: { [weak self] in self?.updateCommentRelay.accept($0) })
    }

    // MARK: - Privates

    private let activityType: ActivityType
    private let projectScope: [ProjectDTO]
    private let projectNamesRelay = BehaviorRelay<[String]>(value: [])
    private let projectSelectedRelay = BehaviorRelay<String>(value: "")
    private let projectInputHiddenRelay = BehaviorRelay(value: false)
    private let hoursInputHiddenRelay = BehaviorRelay(value: false)
    private let commentInputHiddenRelay = BehaviorRelay(value: false)
    private let updateHoursRelay = BehaviorRelay<String>(value: "")
    private let updateCommentRelay = BehaviorRelay<String>(value: "")

    private func configure() {
        projectNamesRelay.accept(projectScope.map { $0.name })
        if case .report(let report) = activityType {
            projectSelectedRelay.accept(projectScope.filter { $0.id == report.projectId }.first?.name ?? "")
            updateHoursRelay.accept(report.value)
            updateCommentRelay.accept(report.comment ?? "")
            if let reportType = ReportType(rawValue: report.reportType) {
                type.onNext(reportType)
            }
        }
    }

}
