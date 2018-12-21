import UIKit

protocol ViewAnimating {
    static func animate(withDuration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?)
}

extension UIView: ViewAnimating {}
