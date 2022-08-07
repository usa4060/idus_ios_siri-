import Alamofire
import Foundation

struct LikeOfflineClassPatchRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
