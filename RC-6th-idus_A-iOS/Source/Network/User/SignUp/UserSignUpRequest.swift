import Foundation
import Alamofire

struct SignUpReq: Codable {
    var email, name, password, phoneNumber: String
}
