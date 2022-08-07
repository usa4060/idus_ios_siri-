import Foundation
import Alamofire

class ChangeMyEmailDataManager{
    func changeEmail( _ email : String, _ viewController : UIViewController, completion: @escaping (_ data: String) -> Void){
        var headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json",
                    "X-ACCESS-TOKEN" : Constant.USER_JWTTOKEN
        ]
        var param : Parameters = [
            "email" : "\(email)"
        ]
        AF.request("\(Constant.BASE_URL)/users/\(Constant.USER_ID)/emails", method: .patch, parameters: param ,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ChangeMyEmailResponse.self){response in
                switch response.result {
                case .success(let response):
                    print("성공")
                    switch response.code{
                    case 1000:
                        completion(response.result)
                    case 2003:
                        completion("권한이 없는 유저의 접근입니다.")
                    case 2020:
                        completion("이메일을 입력해주세요")
                    case 2021:
                        completion("이메일 형식을 확인해주세요")
                    case 2022:
                        completion("이메일 길이를 확인해주세요")
                    default:
                        completion("데이터베이스 연결에 실패하였습니다 : 코드번호 \(response.code)")
                    }
                case .failure(let error):
                    print("회원가입 실패")
                    debugPrint(error)
                }

            }
        
    }
}
