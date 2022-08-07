import Alamofire
import Foundation

struct LikeProductPostRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
