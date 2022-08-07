
import Foundation
import Alamofire

// MARK: - MyInfoDetail
struct MyInfoDetail: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MyInfoDetailResult
}
// MARK: - Result
struct MyInfoDetailResult: Codable {
    var profileImg, userName, email, birthDay, gender, phoneNumber, addressName: String?
}
