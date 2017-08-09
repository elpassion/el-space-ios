import Mapper

struct ReportDTO {
    let id: Int
    let userId: Int
    let projectId: Int?
    let value: String
    let performedAt: String
    let comment: String?
    let createdAt: String
    let updatedAt: String
    let billable: Bool
    let reportType: Int
}

extension ReportDTO: Mappable {

    init(map: Mapper) throws {
        id = try map.from("id")
        userId = try map.from("user_id")
        projectId = map.optionalFrom("project_id")
        value = try map.from("value")
        performedAt = try map.from("performed_at")
        comment = map.optionalFrom("comment")
        createdAt = try map.from("created_at")
        updatedAt = try map.from("updated_at")
        billable = try map.from("billable")
        reportType = try map.from("report_type")
    }

}

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
