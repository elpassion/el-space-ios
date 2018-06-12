@testable import ELSpace

extension ReportDTO {

    static func fakeReportDto(id: Int = 0,
                              userId: Int = 0,
                              projectId: Int? = 0,
                              value: String = "8.0",
                              performedAt: String = "2017-08-01",
                              comment: String? = "fake_comment",
                              createdAt: String = "2017-08-02T12:07:52.752+02:00",
                              updatedAt: String = "2017-08-02T12:07:52.752+02:00",
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

}
