import Foundation

extension Data {

    var jsonArray: [[String: AnyObject]] {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else { fatalError("Data not a json") }
        guard let array = json as? [[String: AnyObject]] else { fatalError("Json not an array") }
        return array
    }

    var json: [String: AnyObject] {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []) else { fatalError("Data not a json") }
        guard let json = jsonObject as? [String: AnyObject] else { fatalError("Json not a dict") }
        return json
    }

}
