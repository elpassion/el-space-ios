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
