import RxSwift

protocol RxReusable {
    var reusabilityDisposeBag: DisposeBag { get }
    func disposeReusabilityBag()
}
