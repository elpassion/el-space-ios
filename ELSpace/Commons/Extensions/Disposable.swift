import RxSwift

extension Disposable {

    func disposed(by compositeDisposable: CompositeDisposable) {
        _ = compositeDisposable.insert(self)
    }

}
