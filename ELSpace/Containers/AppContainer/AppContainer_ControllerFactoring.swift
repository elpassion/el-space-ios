protocol ControllerFactoring {
    func selectionController(googleIdToken: String) -> SelectionControllerSignIn
}

extension AppContainer: ControllerFactoring {

    func selectionController(googleIdToken: String) -> SelectionControllerSignIn {
        return SelectionController(hubTokenService: hubTokenService,
                                   googleIdToken: googleIdToken)
    }

}
