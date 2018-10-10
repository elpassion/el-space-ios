import Foundation
import RxSwift
import RxCocoa

protocol ActivityFormViewInputModeling {
    var performedAt: Observable<String> { get }
    var projectNames: Observable<[String]> { get }
    var projectSelected: Observable<ProjectDTO> { get }
    var selectedProject: ProjectDTO? { get }
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
        self.projectScope = projectScope.prefix(upTo: 3) + projectScope.suffix(from: 3).sorted { $0.name < $1.name }
        configure()
    }

    // MARK: - ActivityFormViewInputModeling

    var performedAt: Observable<String> {
        return performedAtRelay.asObservable()
    }

    var projectNames: Observable<[String]> {
        return projectsRelay.asObservable().map { $0.map { $0.name } }
    }

    var projectSelected: Observable<ProjectDTO> {
        return projectSelectedRelay.unwrap().asObservable()
    }

    var selectedProject: ProjectDTO? {
        return projectSelectedRelay.value
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
        return Observable.combineLatest(projectSelectedRelay,
                                        updateHoursRelay,
                                        updateCommentRelay,
                                        projectInputHiddenRelay,
                                        hoursInputHiddenRelay,
                                        commentInputHiddenRelay,
                                        performedAtRelay)
            .map { ActivityForm(projectId: $0.3 ? nil : $0.0?.id,
                                hours: $0.4 ? nil : Double(from: $0.1),
                                comment: $0.5 ? nil : $0.2,
                                date: $0.6)
            }
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
        return AnyObserver(onNext: { [weak self] name in
            let project = self?.projectScope.filter { $0.name == name }.first
            self?.projectSelectedRelay.accept(project)
        })
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
    private let performedAtRelay = BehaviorRelay<String>(value: "")
    private let projectsRelay = BehaviorRelay<[ProjectDTO]>(value: [])
    private let projectSelectedRelay = BehaviorRelay<ProjectDTO?>(value: nil)
    private let projectInputHiddenRelay = BehaviorRelay(value: false)
    private let hoursInputHiddenRelay = BehaviorRelay(value: false)
    private let commentInputHiddenRelay = BehaviorRelay(value: false)
    private let updateHoursRelay = BehaviorRelay<String>(value: "")
    private let updateCommentRelay = BehaviorRelay<String>(value: "")

    private func configure() {
        projectsRelay.accept(projectScope)
        switch activityType {
        case .report(let report): performedAtRelay.accept(report.performedAt)
        case .new(let date):
            let dateFormatter = DateFormatter.shortDateFormatter
            performedAtRelay.accept(dateFormatter.string(from: date))
        }
        if case .report(let report) = activityType {
            projectSelectedRelay.accept(projectScope.filter { $0.id == report.projectId }.first)
            updateHoursRelay.accept(report.value)
            updateCommentRelay.accept(report.comment ?? "")
            if let reportType = ReportType(rawValue: report.reportType) {
                type.onNext(reportType)
            }
        }
    }

}
