import FBSnapshotTestCase
import RxSwift

@testable import ELSpace

class ActivitiesViewControllerTests: FBSnapshotTestCase {

    var sut: ActivitiesViewController!
    var coordinator: ActivitiesCoordinator!
    var viewModel: ActivitiesViewModel!
    var activitiesControllingStub: ActivitiesControllingStub!

    override func setUp() {
        super.setUp()
        recordMode = false
        isDeviceAgnostic = true
        activitiesControllingStub = ActivitiesControllingStub()
        viewModel = ActivitiesViewModel(activitiesController: activitiesControllingStub,
                                        todayDate: dateFormatter.date(from: "2017-12-05")!)
        sut = ActivitiesViewController()
        coordinator = ActivitiesCoordinator(viewController: sut,
                                            activitiesViewController: sut,
                                            viewModel: viewModel)
        sut.view.frame = UIScreen.main.bounds
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        coordinator = nil
        viewModel = nil
        activitiesControllingStub = nil
    }

    func testFilledList() {
        activitiesControllingStub.projectsSubject.onNext(projects)
        activitiesControllingStub.reportsSubject.onNext([
            firstNormalReport,
            secondNormalReport,
            paidVacationReport,
            unpaidVacationReport,
            sickLeaveReport,
            thirdNormalReport])
        activitiesControllingStub.didFinishFetchSubject.onNext(())
        verifyView()
    }

    // MARK: - Helpers

    private func verifyView() {
        FBSnapshotVerifyView(sut.view)
        expectation(description: "Should display correct view").fulfill()
        waitForExpectations(timeout: 5.0)
    }

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.timeZone = TimeZone(identifier: "Europe/Warsaw")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    // MARK: - Fake data source

    // MARK: - Reports

    private var firstNormalReport: ReportDTO {
        return defaultReportDTO()
    }

    private var secondNormalReport: ReportDTO {
        return defaultReportDTO(projectId: 2, value: "8.0")
    }

    private var thirdNormalReport: ReportDTO {
        return defaultReportDTO(projectId: 3, value: "5.0", performedAt: "2017-12-03")
    }

    private var paidVacationReport: ReportDTO {
        return defaultReportDTO(projectId: nil, performedAt: "2017-12-05", comment: nil, reportType: 1)
    }

    private var unpaidVacationReport: ReportDTO {
        return defaultReportDTO(projectId: nil, performedAt: "2017-12-06", comment: nil, reportType: 2)
    }

    private var sickLeaveReport: ReportDTO {
        return defaultReportDTO(projectId: nil, performedAt: "2017-12-07", comment: nil, reportType: 3)
    }

    private func defaultReportDTO(id: Int = 1,
                                  userId: Int = 1,
                                  projectId: Int? = 1,
                                  value: String = "8.0",
                                  performedAt: String = "2017-12-01",
                                  comment: String? = "fake_comment",
                                  createdAt: String = "fake_created_at",
                                  updatedAt: String = "fake_updated_at",
                                  billable: Bool = true,
                                  reportType: Int = 0) -> ReportDTO {
        return ReportDTO(id: id,
                         userId: userId,
                         projectId: projectId,
                         value: value,
                         performedAt: performedAt,
                         comment: comment,
                         createdAt: createdAt,
                         updatedAt: updatedAt,
                         billable: billable,
                         reportType: reportType)
    }

    // MARK: - Projects

    private var projects: [ProjectDTO] {
        return [firstProjectDTO,
                secondProjectDTO,
                thirdProjectDTO,
                fourthProjectDTO,
                fifthProjectDTO]
    }

    private var firstProjectDTO: ProjectDTO {
        return ProjectDTO(name: "Project id: 1", id: 1)
    }

    private var secondProjectDTO: ProjectDTO {
        return ProjectDTO(name: "Project id: 2", id: 2)
    }

    private var thirdProjectDTO: ProjectDTO {
        return ProjectDTO(name: "Project id: 3", id: 3)
    }

    private var fourthProjectDTO: ProjectDTO {
        return ProjectDTO(name: "Project id: 4", id: 4)
    }

    private var fifthProjectDTO: ProjectDTO {
        return ProjectDTO(name: "Project id: 5", id: 5)
    }

}
