import UIKit

extension AppContainer {

    var viewControllerPresenter: ViewControllerPresenting {
        return ViewControllerPresenter()
    }

    var modalViewControllerPresenter: ModalViewControllerPresenting {
        return ModalViewControllerPresenter(
            presentTransition: { ModalViewControllerPresentTransition(animator: Animator()) },
            dismissTransition: { ModalViewControllerDismissTransition(animator: Animator()) }
        )
    }

}
