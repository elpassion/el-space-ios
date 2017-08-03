import Foundation

extension Data {

    var jsonArray: [[String: Any]] {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else { fatalError("Data not a json") }
        guard let array = json as? [[String: Any]] else { fatalError("Json not an array") }
        return array
    }

}
