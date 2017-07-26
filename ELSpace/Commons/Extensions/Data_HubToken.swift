import Foundation

extension Data {

    var hubToken: String {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else { fatalError("Data not a json") }
        guard let dict = json as? [String: Any] else { fatalError("Json cast error") }
        guard let token = dict["access_token"] as? String else { fatalError("Wrong key") }
        return token
    }

}
