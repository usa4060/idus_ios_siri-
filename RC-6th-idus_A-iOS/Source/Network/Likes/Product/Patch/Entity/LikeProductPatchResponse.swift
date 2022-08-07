import Alamofire
import Foundation

struct LikeProductPatchRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
