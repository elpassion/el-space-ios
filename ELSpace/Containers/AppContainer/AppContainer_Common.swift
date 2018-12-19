import UIKit

extension AppContainer {

    // MARK: - Controllers

    func selectionController(googleIdToken: String) -> SelectionControllerSignIn {
        return SelectionController(hubTokenService: hubTokenService, googleIdToken: googleIdToken)
    }

    var activitiesController: ActivitiesControlling {
        return ActivitiesController(reportsService: reportsService,
                                    projectsService: projectsService,
                                    holidaysService: holidaysService)
    }

    var projectSearchController: ProjectSearchControlling {
        return ProjectSearchController(projectsService: projectsService)
    }

    // MARK: - Mappers

    var googleUserMapper: GoogleUserMapping {
        return GoogleUserMapper()
    }

    // MARK: - SelectionScreenPresenterCreation

    func selectionScreenPresenter(presenterViewController: UIViewController) -> SelectionScreenPresenting {
        return SelectionScreenPresenter(activitiesCoordinatorFactory: self,
                                        viewControllerPresenter: viewControllerPresenter,
                                        presenterViewController: presenterViewController)
    }

}
