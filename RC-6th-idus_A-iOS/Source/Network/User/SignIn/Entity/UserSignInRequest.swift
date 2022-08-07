import Foundation
import Alamofire

struct SignInReq: Codable {
    var email, password: String
}
