import Alamofire
import Foundation

struct LikeOnlineClassPatchRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
