import Foundation

class ApiError: Error {

    let statusCode: Int

    init?(response: Response) {
        switch response.statusCode {
        case 200...299: return nil
        default: self.statusCode = response.statusCode
        }
    }

}
