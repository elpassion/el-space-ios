@testable import ELSpace

class SelectionScreenPresenterMock: SelectionScreenPresenting {

    var didCallPresentHub: Bool {
        return presentHubCount > 0
    }

    var didCallPresentDebate: Bool {
        return presentDebateCount > 0
    }

    private(set) var presentHubCount = 0
    private(set) var presentDebateCount = 0

    // MARK: - SelectionScreenPresenting

    func presentHub() {
        presentHubCount += 1
    }

    func presentDebate() {
        presentDebateCount += 1
    }

}
