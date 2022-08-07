import Foundation
import Alamofire

class LikeOfflineClassPostDataManager{
    func LikeOfflineClassPost( _ offClassID : Int, _ viewController : UIViewController, completion: @escaping (_ data: String) -> Void){
        var headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json",
                    "X-ACCESS-TOKEN" : Constant.USER_JWTTOKEN
        ]
        AF.request("\(Constant.BASE_URL)/online-classes/\(Constant.USER_ID)/\(offClassID)/likes", method: .post, parameters: nil ,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: LikeOfflineClassPostRes.self){response in
                switch response.result {
                case .success(let response):
                    print("성공")
                    switch response.code{
                    case 1000:
                        completion(response.result)
                    case 2003:
                        completion("권한이 없는 유저의 접근입니다.")
                    case 3030:
                        completion("존재하지 않는 오프라인 클래스입니다.")
                    case 3310:
                        completion("중복되는 오프라인 클래스 찜입니다")
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
