import Alamofire
import Foundation

struct DeleteMyInfoRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
