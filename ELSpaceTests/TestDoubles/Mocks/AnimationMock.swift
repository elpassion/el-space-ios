import Foundation
@testable import ELSpace

class AnimatorMock: Animating {

    var animatingWithDuration: TimeInterval?
    var animations: (() -> Void)?
    var completion: ((Bool) -> Void)?

    // MARK: Animating

    func animate(withDuration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        animatingWithDuration = withDuration
        self.animations = animations
        self.completion = completion
    }

}
