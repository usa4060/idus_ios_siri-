import Alamofire
import Foundation

struct LikeOfflineClassPostRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
