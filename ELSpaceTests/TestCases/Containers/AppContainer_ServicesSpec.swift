import Alamofire
import Quick
import Nimble

@testable import ELSpace

class AppContainer_ServicesSpec: QuickSpec {

    override func spec() {
        describe("AppContainer_Services") {
            var sut: AppContainer!

            beforeEach {
                sut = AppContainer()
            }

            it("should return SessionManager") {
                expect(sut.sessionManager) === SessionManager.default
            }

            it("should build RequestPerformer") {
                expect(sut.requestPerformer).to(beAnInstanceOf(RequestPerformer.self))
            }

            it("should build ApiClient") {
                expect(sut.apiClient).to(beAnInstanceOf(ApiClient.self))
            }

            it("should build HubTokenService") {
                expect(sut.hubTokenService).to(beAnInstanceOf(HubTokenService.self))
            }

            it("should build GoogleUserManager") {
                expect(sut.googleUserManager).to(beAnInstanceOf(GoogleUserManager.self))
            }

            it("should build ApiClientHubDecorator") {
                expect(sut.apiClientHubDecorator).to(beAnInstanceOf(ApiClientHubDecorator.self))
            }

            it("should build ReportsService") {
                expect(sut.reportsService).to(beAnInstanceOf(ReportsService.self))
            }

            it("should build ProjectsService") {
                expect(sut.projectsService).to(beAnInstanceOf(ProjectsService.self))
            }

            it("should build ActivityService") {
                expect(sut.activityService).to(beAnInstanceOf(ActivityService.self))
            }

            it("should build HolidaysService") {
                expect(sut.holidaysService).to(beAnInstanceOf(HolidaysService.self))
            }
        }
    }
}
