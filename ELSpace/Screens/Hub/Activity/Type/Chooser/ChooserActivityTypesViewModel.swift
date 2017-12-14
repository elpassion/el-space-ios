class ChooserActivityTypesViewModel: ChooserActivityTypesViewModeling {

    var activityTypeViewModels: [ActivityTypeViewModeling] {
        let viewModel1 = ActivityTypeViewModel()
        viewModel1.title = "test 1"
        let viewModel2 = ActivityTypeViewModel()
        viewModel2.title = "test 2"
        return [viewModel1, viewModel2]
    }

}
