import RxSwift
import RxCocoa

/**
 Enables monitoring of sequence computation.
 If there is at least one sequence computation in progress, `true` will be sent.
 When all activities complete `false` will be sent.
 */
final class ActivityIndicator: SharedSequenceConvertibleType {

    // swiftlint:disable:next type_name
    typealias E = Bool
    typealias SharingStrategy = DriverSharingStrategy

    init() {
        loading = variable.asDriver().map { $0 > 0 }.distinctUntilChanged()
    }

    private let lock = NSRecursiveLock()
    private let variable = Variable(0)
    private let loading: SharedSequence<SharingStrategy, Bool>

    fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.E> {
        return Observable.using({ () -> ActivityToken<O.E> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }, observableFactory: { $0.asObservable() })
    }

    var isActive: Bool {
        return variable.value > 0
    }

    func increment() {
        lock.lock()
        variable.value += 1
        lock.unlock()
    }

    func decrement() {
        lock.lock()
        variable.value -= 1
        lock.unlock()
    }

    func asSharedSequence() -> SharedSequence<SharingStrategy, E> {
        return loading
    }

}

extension ObservableConvertibleType {

    func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<E> {
        return activityIndicator.trackActivityOfObservable(self)
    }

}

private struct ActivityToken<E> : ObservableConvertibleType, Disposable {

    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        self.source = source
        disposable = Disposables.create(with: disposeAction)
    }

    func dispose() {
        disposable.dispose()
    }

    func asObservable() -> Observable<E> {
        return source
    }

    private let source: Observable<E>
    private let disposable: Cancelable

}

