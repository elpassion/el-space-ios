import UIKit
import ELDebate

extension AppContainer: SelectionScreenPresenterCreation {

    var debateRunner: DebateRunning {
        return DebateRunner()
    }

    // MARK: - Controllers

    func selectionController(googleIdToken: String) -> SelectionControllerSignIn {
        return SelectionController(hubTokenService: hubTokenService,
                                   googleIdToken: googleIdToken)
    }

    var activityController: ActivityControlling {
        return ActivityController(reportsService: reportsService)
    }

    // MARK: - Presenters

    var viewControllerPresenter: ViewControllerPresenting {
        return ViewControllerPresenter()
    }

    // MARK: - Mappers

    var googleUserMapper: GoogleUserMapping {
        return GoogleUserMapper()
    }

    // MARK: - SelectionScreenPresenterCreation

    func selectionScreenPresenter(presenterViewController: UIViewController) -> SelectionScreenPresenting {
        return SelectionScreenPresenter(debateRunner: debateRunner,
                                        activityCoordinatorFactory: self,
                                        viewControllerPresenter: viewControllerPresenter,
                                        presenterViewController: presenterViewController)
    }

}

protocol SelectionScreenPresenterCreation {
    func selectionScreenPresenter(presenterViewController: UIViewController) -> SelectionScreenPresenting
}
