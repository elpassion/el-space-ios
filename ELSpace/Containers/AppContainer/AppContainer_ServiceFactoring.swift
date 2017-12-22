import Alamofire

extension AppContainer {

    var sessionManager: RequestWrapper {
        return SessionManager.default
    }

    var requestPerformer: Requesting {
        return RequestPerformer(sessionManager: sessionManager)
    }

    var apiClient: ApiClientProtocol {
        return ApiClient(requestPerformer: requestPerformer)
    }

    var hubTokenService: HubTokenServiceProtocol {
        return HubTokenService(apiClient: apiClient)
    }

    var googleUserManager: GoogleUserManaging {
        return GoogleUserManager()
    }

    var apiClientHubDecorator: ApiClientProtocol {
        return ApiClientHubDecorator(apiClient: apiClient, hubSession: hubSession)
    }

    var reportsService: ReportsServiceProtocol {
        return ReportsService(apiClient: apiClientHubDecorator)
    }

    var projectsService: ProjectsServiceProtocol {
        return ProjectsService(apiClient: apiClientHubDecorator)
    }

    var activitiesService: ActivitiesServiceProtocol {
        return ActivitiesService(apiClient: apiClientHubDecorator)
    }

}
