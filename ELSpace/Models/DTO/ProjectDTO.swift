import Mapper

struct ProjectDTO {
    let name: String
    let id: Int
}

extension ProjectDTO: Mappable {

    init(map: Mapper) throws {
        name = try map.from("name")
        id = try map.from("id")
    }

}

extension ProjectDTO {

    static func fakeProjectDto(name: String = "Slack time", id: Int = 0) -> ProjectDTO {
        return ProjectDTO(name: name, id: id)
    }

}
