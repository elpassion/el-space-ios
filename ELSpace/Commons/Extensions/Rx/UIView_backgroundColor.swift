import RxSwift

extension Reactive where Base: UIView {

    var backgroundColor: AnyObserver<UIColor> {
        return AnyObserver(onNext: { [weak base] in base?.backgroundColor = $0 })
    }

}
