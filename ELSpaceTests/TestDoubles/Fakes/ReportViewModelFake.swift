@testable import ELSpace

import Foundation

class ReportViewModelFake: ReportViewModelProtocol {

    init(projectId: Int? = 0,
         date: Date = Date(),
         value: Double = 8.0,
         comment: String? = "fake_comment",
         type: Int = 0) {
        self.projectId = projectId
        self.date = date
        self.value = value
        self.comment = comment
        self.type = type
    }

    // MARK: - ReportViewModelProtocol

    let projectId: Int?
    let date: Date
    let value: Double
    let comment: String?
    let type: Int

}
