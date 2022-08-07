import Foundation
import Alamofire

// MARK: - MyInfo
struct MyInfo: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MyInfoReqResult
}

// MARK: - Result
struct MyInfoReqResult: Codable {
    let profileImg, grade, userName: String
    let rewardPoint, countCoupon: Int
}
