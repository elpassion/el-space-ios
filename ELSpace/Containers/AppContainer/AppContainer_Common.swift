import UIKit
import ELDebate

extension AppContainer: SelectionScreenPresenterCreation {

    var debateRunner: DebateRunning {
        return DebateRunner()
    }

    // MARK: - Controllers

    func selectionController(googleIdToken: String) -> SelectionControllerSignIn {
        return SelectionController(hubTokenService: hubTokenService, googleIdToken: googleIdToken)
    }

    var activitiesController: ActivitiesControlling {
        return ActivitiesController(reportsService: reportsService,
                                    projectsService: projectsService,
                                    holidaysService: holidaysService)
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
                                        activitiesCoordinatorFactory: self,
                                        viewControllerPresenter: viewControllerPresenter,
                                        presenterViewController: presenterViewController)
    }

}

protocol SelectionScreenPresenterCreation {
    func selectionScreenPresenter(presenterViewController: UIViewController) -> SelectionScreenPresenting
}
