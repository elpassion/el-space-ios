import RxSwift

extension Reactive where Base: UIViewController {

    var viewDidAppear: Observable<Void> {
        return methodInvoked(#selector(base.viewDidAppear(_:))).map { _ in () }
    }

}
