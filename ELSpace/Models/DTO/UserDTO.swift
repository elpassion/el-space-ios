import Mapper

struct UserDTO {
    let id: Int
}

extension UserDTO: Mappable {
    
    init(map: Mapper) throws {
        id = try map.from("id")
    }
    
}
