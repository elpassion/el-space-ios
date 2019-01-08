import Foundation
@testable import ELSpace

class AnimatorMock: ViewAnimating {

    private(set) static var animatingWithDuration: TimeInterval?
    private(set) static var animations: (() -> Void)?
    private(set) static var completion: ((Bool) -> Void)?

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
