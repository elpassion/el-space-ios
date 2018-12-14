import UIKit

protocol Animating {
    func animate(withDuration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?)
}

class Animator: Animating {

    func animate(withDuration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: withDuration, animations: animations, completion: completion)
    }

}
