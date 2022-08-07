import Foundation
import Alamofire

class ChangeMyPhoneNumberDataManager{
    func changePhoneNumber( _ phoneNumber : String, _ viewController : UIViewController, completion: @escaping (_ data: String) -> Void){
        var headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json",
                    "X-ACCESS-TOKEN" : Constant.USER_JWTTOKEN
        ]
        var param : Parameters = [
            "phoneNumber" : "\(phoneNumber)"
        ]
        AF.request("\(Constant.BASE_URL)/users/\(Constant.USER_ID)/phoneNumbers", method: .patch, parameters: param ,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ChangeMyPhoneNumber.self){response in
                switch response.result {
                case .success(let response):
                    print("성공")
                    switch response.code{
                    case 1000:
                        completion(response.result)
                    case 2003:
                        completion("권한이 없는 유저의 접근입니다.")
                    case 2030:
                        completion("휴대폰 번호를 입력해주세요")
                    case 2031:
                        completion("잘못된 휴대폰 번호입니다")
                    default:
                        completion("데이터베이스 연결에 실패하였습니다 : 코드번호 \(response.code)")
                    }
                case .failure(let error):
                    print("회원가입 실패")
                    print(error.localizedDescription)
                    print("@@@@@@@@@@@@@")
                    debugPrint(error)
                }

            }
        
    }
}
