import Alamofire
import Foundation

struct LikeOnlineClassPostRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
