import UIKit
import MBProgressHUD
import RxSwift

class LoadingIndicator {

    init(superView: UIView) {
        self.superView = superView
    }

    deinit {
        hud?.hide(animated: true)
    }

    func loading(_ loading: Bool) {
        if loading {
            operationsCount += 1
        } else if operationsCount >= 1 {
            operationsCount -= 1
        }
    }

    // MARK: - Private

    private let superView: UIView
    private weak var hud: MBProgressHUD?

    private var operationsCount: UInt = 0 {
        didSet {
            updateHud()
        }
    }

    private func updateHud() {
        if operationsCount > 0 {
            hud = MBProgressHUD.showAdded(to: superView, animated: true)
        } else if operationsCount <= 0 {
            hud?.hide(animated: true)
        }
    }

}

extension LoadingIndicator: ReactiveCompatible {}

extension Reactive where Base: LoadingIndicator {

    var isLoading: AnyObserver<Bool> {
        return AnyObserver(eventHandler: { [weak base] event in
            guard let element = event.element else { return }
            base?.loading(element)
        })
    }

}
