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
