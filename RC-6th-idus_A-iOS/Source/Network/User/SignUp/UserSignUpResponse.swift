import Foundation
import Alamofire

struct SignUpRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SignUpResult?
    
//    private enum CodingKeys: String, CodingKey{
//        case inSuccess, code, message, result
//    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        result = (try? values.decode( SignUpResult.self, forKey: .result)) ?? SignUpResult(jwt: "", userID: 0)
//    }
}


struct SignUpResult: Codable {
    let jwt: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case jwt
        case userID = "userId"
    }
}
