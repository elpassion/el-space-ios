import Foundation

extension Data {

    var jsonArray: [[String: AnyObject]] {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else { fatalError("Data not a json") }
        guard let array = json as? [[String: AnyObject]] else { fatalError("Json not an array") }
        return array
    }

}
