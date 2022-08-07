import Alamofire
import Foundation

struct ChangeMyEmailResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
