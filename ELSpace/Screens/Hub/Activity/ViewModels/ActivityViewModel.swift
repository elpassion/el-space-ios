import RxSwift

protocol ActivityViewModelProtocol {
    var addAction: AnyObserver<Void> { get }
}

class ActivityViewModel: ActivityViewModelProtocol {

    init(service: ActivitiesServiceProtocol) {
        self.service = service
    }

    // MARK: ActivityViewModelProtocol

    var addAction: AnyObserver<Void> {
        return AnyObserver(onNext: { print("ADD action not implemented") })
    }

    // MARK: Private

    private let service: ActivitiesServiceProtocol

}
