import Foundation
import Alamofire

struct SignInRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SignInResult?
}


struct SignInResult: Codable {
    let jwt: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case jwt
        case userID = "userId"
    }
}
