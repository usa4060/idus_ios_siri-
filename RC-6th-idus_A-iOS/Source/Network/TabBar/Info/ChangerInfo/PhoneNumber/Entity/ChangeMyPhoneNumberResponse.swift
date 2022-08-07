import Alamofire
import Foundation

struct ChangeMyPhoneNumber: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
    
    enum CodingKeys: String, CodingKey {
        case isSuccess, code, message, result
    }
}
