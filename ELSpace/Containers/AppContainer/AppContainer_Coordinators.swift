import Foundation

extension AppContainer: SelectionCoordinatorCreation,
                        ActivitiesCoordinatorCreation,
                        ActivityCoordinatorCreation,
                        ProjectSearchCoordinatorCreation {

    // MARK: - SelectionCoordinatorCreation

    func selectionCoordinator(googleIdToken: String) -> Coordinator {
        let viewController = selectionViewController(googleIdToken: googleIdToken)
        let selectionScreenPresenter = self.selectionScreenPresenter(presenterViewController: viewController)
        return SelectionCoordinator(viewController: viewController,
                                    selectionViewController: viewController,
                                    selectionScreenPresenter: selectionScreenPresenter,
                                    hubSession: hubSession)
    }

    // MARK: - ActivityCoordinatorCreation

    func activitiesCoordinator() -> Coordinator {
        return ActivitiesCoordinator(activitiesViewController: activitiesViewController(),
                                     monthPickerViewControllerFactory: self,
                                     activitiesViewModel: activitiesViewModel(),
                                     presenter: ViewControllerPresenter(),
                                     modalPresenter: modalViewControllerPresenter,
                                     activityCoordinatorFactory: self)
    }

    // MARK: - ActivityCoordinatorCreation

    func activityCoordinator(activityType: ActivityType, projectScope: [ProjectDTO]) -> Coordinator {
        return ActivityCoordinator(viewController: activityViewController(activityType: activityType, projectScope: projectScope),
                                   viewModel: activityViewModel(activityType: activityType, projectScope: projectScope),
                                   projectSearchCoordinatorFactory: self,
                                   presenter: ViewControllerPresenter())
    }

    // MARK: - ProjectSearchCoordinatorCreation

    func projectSearchCoordinator(projectId: Int?) -> Coordinator {
        return ProjectSearchCoordinator(projectSearchViewController: projectSearchViewController(projectId: projectId),
                                        projectSearchViewModel: projectSearchViewModel(projectId: projectId))
    }

}

protocol SelectionCoordinatorCreation {
    func selectionCoordinator(googleIdToken: String) -> Coordinator
}

protocol ActivitiesCoordinatorCreation {
    func activitiesCoordinator() -> Coordinator
}

protocol ActivityCoordinatorCreation {
    func activityCoordinator(activityType: ActivityType, projectScope: [ProjectDTO]) -> Coordinator
}

protocol ProjectSearchCoordinatorCreation {
    func projectSearchCoordinator(projectId: Int?) -> Coordinator
}
