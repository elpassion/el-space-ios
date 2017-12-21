import RxSwift

extension AnyObserver {

    init(onNext: ((Element) -> Void)? = nil,
         onError: ((Error) -> Void)? = nil,
         onCompleted: (() -> Void)? = nil) {
        self.init(eventHandler: {
            switch $0 {
            case .next(let element): onNext?(element)
            case .error(let error): onError?(error)
            case .completed: onCompleted?()
            }
        })
    }

}
