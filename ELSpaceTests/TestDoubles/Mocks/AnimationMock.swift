import Foundation
@testable import ELSpace

class AnimatorMock: ViewAnimating {

    static var animatingWithDuration: TimeInterval?
    static var animations: (() -> Void)?
    static var completion: ((Bool) -> Void)?

    static func prepare() {
        animatingWithDuration = nil
        animations = nil
        completion = nil
    }

    // MARK: ViewAnimating

    static func animate(withDuration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        animatingWithDuration = withDuration
        self.animations = animations
        self.completion = completion
    }

}
