import RxSwift

protocol ActivityViewModelProtocol {
    var addAction: AnyObserver<Void> { get }
}

class ActivityViewModel: ActivityViewModelProtocol {

    // MARK: ActivityViewModelProtocol

    var addAction: AnyObserver<Void> {
        return AnyObserver(onNext: { print("ADD action not implemented") })
    }

}
