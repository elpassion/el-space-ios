import Mapper

struct HolidaysDTO {
    let days: [Int]
}

extension HolidaysDTO: Mappable {

    init(map: Mapper) throws {
        days = try map.from("holidays")
    }

}
