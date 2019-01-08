import UIKit

extension AppContainer {

    var viewControllerPresenter: ViewControllerPresenting {
        return ViewControllerPresenter()
    }

    var modalViewControllerPresenter: ModalViewControllerPresenting {
        return ModalViewControllerPresenter(configuration: basicModalPresentationConfiguration)
    }

    var basicModalPresentationConfiguration: ModalPresentationConfiguration {
        return ModalPresentationConfiguration(
            animated: true,
            presentTransition: ModalViewControllerPresentTransition(animator: UIView.self),
            dismissTransition: ModalViewControllerDismissTransition(animator: UIView.self),
            presentationStyle: .overFullScreen
        )
    }

}
